Return-Path: <linux-kernel+bounces-198629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AD8D7B62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E72B2174F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30624A08;
	Mon,  3 Jun 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azgHYuGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D9374C3;
	Mon,  3 Jun 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395107; cv=none; b=AiA+3Vc7I+4JwlKjUyHrYB0ywgnKPNLSgAFgi7VG/fF5x/v5FoWUkbEdoLCGIiEMoWvfNw5h8j2+82dIReyEr8XDgAGqd5zrGCkstweGgu5OVYaAW7LT/n5HLbLT8GISVbXelVvHglvbYQIMjGN5wUd0VYo8rUwEZFxdr0GlFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395107; c=relaxed/simple;
	bh=uuBWVXHe03mkIiLXfqEB1wHYxIW6X+fBhN1iDdRQl1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nk0vrgd7Rz//upRVxNKHr+6IVQCp6olSRicuqc9rqHPEekCt71/fIggL/o5O5Hup1tRWRzaBxbjlmXbUp+hQ+eP9KzF26NkZZaHZpZbKV52HEMqeUOCePGfXbtIp6QLiJqyoIVIaUvmTA+WM3z/xpMPOd0k3E3XvlxkMIInnB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azgHYuGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD2C2BD10;
	Mon,  3 Jun 2024 06:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717395107;
	bh=uuBWVXHe03mkIiLXfqEB1wHYxIW6X+fBhN1iDdRQl1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=azgHYuGbNKcNDVsDBelLAEKWb6dE6PsnYmbI/9ivhIsRK5QnvTmAxKZG0Ec+xRPb/
	 sIlVq6+iAW2/965QpdtlAFVvpqfuo6Ac8eQgMwy0TfNCs/qw4V8YzzxF/NZtbv7gfc
	 Pyfvi/SF25HRii4c1cx08SXkA2dFpUPrMk23SqF3Nbo0Ha/Nt5edDBsHZSZ9qfvfeG
	 CiavIkummp7SyzVxTA0ZkpczVYW4BBXjpvADxCTqNwMZ7e/QSz6CV0Ll7oZZp7+duQ
	 3NROJm9k63+bNNLTJTb9uYsT6NxGZiatviwlmfDWQ2vyZMsE7CB0Yqmd/Efgl5Ji9Q
	 YtrsXULsI2xoQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: bard.liao@intel.com, pierre-louis.bossart@linux.intel.com, 
 linux-kernel@vger.kernel.org, vinod.koul@linaro.org
In-Reply-To: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
References: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: fix usages of device_get_named_child_node()
Message-Id: <171739510483.479714.7469467441579202201.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 11:41:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 29 Apr 2024 00:49:35 +0000, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The documentation for device_get_named_child_node() mentions this
> important point:
> 
> "
> The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer.
> "
> 
> [...]

Applied, thanks!

[1/1] soundwire: fix usages of device_get_named_child_node()
      commit: 55953994903c3b6ef7b520b8f0632245fb718692

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


