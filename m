Return-Path: <linux-kernel+bounces-551246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A1A56A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AE33A76BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48321B9C8;
	Fri,  7 Mar 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKt1oP8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B721ABC3;
	Fri,  7 Mar 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356579; cv=none; b=HVqFCMtqpo8StCo04lQ5LlzuEUVfVQNf/YdFmHZ+cQ/mGP4BUB4gk6turc7KG0lJXajMYgV49m41rFneFC4O/dh1tTHhBT5fyFG5CTtuzMce0w29KBIE9sDAkOnNIUEZRnBdhwnWa8RtaxLxwzy/C23U9JZKD9Wa3GxGyXrP1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356579; c=relaxed/simple;
	bh=PhF5vbdvBr6B55g5q/tZQ/atXs6+DR2Ee7xz3YBPnSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTYUGYbNMKJB35khCVas8a/9TjSBfnkbBLNJ1CQhi7urMDdRhvFi/1V1gsv0gVUxA5CuX5QPUsUchEKP6HVb18vsxPX3PHvsa6cRraNXm743yMChNOppUhBNNOJLkSGimrshRizY/nxwyeYcPKhfStcgRvk5oo1v0Gi+z6Z71v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKt1oP8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42E1C4CEE5;
	Fri,  7 Mar 2025 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356578;
	bh=PhF5vbdvBr6B55g5q/tZQ/atXs6+DR2Ee7xz3YBPnSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKt1oP8FJAZyYY0rW7fxVmrhhj4jqHJ1hX+JcIevuVoHcGnh5lmvhgIGG5Wr3DbTG
	 cAy1/OogXJEOuYVzLL8Gs4hY8B7fL6FWdESVE2iJVOzpE7sj87pkwcqXbX19IyRbrb
	 0E7LFWESOI04Mo0vPuy57mlCLNJV/DOeDJVLVJxrifSms8f8IKbB7NFGw/6WQrlGES
	 u9iR8ZuO59mlWCwAlWW4DTsm3jMvpoyiaFs1REvqG1LDfnc6lfLYQV07LcDkt2J5lI
	 5wF8eabhqQFB65doKVOkPUAQFMprR2smymJSdWfPTKH5KBpJWJYVkHGR86keSqg1oC
	 qhJgYZPRaNI0Q==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	lorenzo@kernel.org,
	Maninder Singh <maninder1.s@samsung.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chungki0201.woo@samsung.com
Subject: Re: [PATCH 1/2] NFSD: unregister filesystem in case genl_register_family() fails
Date: Fri,  7 Mar 2025 09:09:34 -0500
Message-ID: <174135655901.96609.15950223024137816385.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250306092007.1419237-1-maninder1.s@samsung.com>
References: <CGME20250306092017epcas5p30812b135b484fdea1f96739635df1d79@epcas5p3.samsung.com> <20250306092007.1419237-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 06 Mar 2025 14:50:06 +0530, Maninder Singh wrote:
> With rpc_status netlink support, unregister of register_filesystem()
> was missed in case of genl_register_family() fails.
> 
> Correcting it by making new label.
> 
> 

Applied to nfsd-testing, thanks!

[1/2] NFSD: unregister filesystem in case genl_register_family() fails
      commit: 4c9f0119568834eb4c7f5ce6706ec52a1a426c4c
[2/2] NFSD: fix race between nfsd registration and exports_proc
      commit: 5f5262b46b823cfcfdf224b1b6a5ba3027453ea1

--
Chuck Lever


