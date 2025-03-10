Return-Path: <linux-kernel+bounces-555050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC12A5A4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483C17A69D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711241DE3DF;
	Mon, 10 Mar 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxze76bF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF79EC5;
	Mon, 10 Mar 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638301; cv=none; b=frwNo8qF3beSkkL9OjHE1YIaOHD80RWoOkDoRiLeFdRoGIU4i7dV1LExUeW0alwaHp+ilpZKVMQEoZxpA2kpeej578HbpXf9PXq+nShFPNAiieD0YRMzXKmAhgbgAPk7PBHez/J6mbsQfm8DhWK8nCsGABLEl58VIXtTzitjItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638301; c=relaxed/simple;
	bh=+UYvo9vFDGsDU6NgUSI0lJczQ7FGUwfcAkWsdmdPEC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7Ibm77vPQxsQMcl3YIHO+/Sos89PhWyWwRUWaOclEl+PWKBd2gsig9aSuITB959p+eza0J7awr1fF9mVf/oAIiI9FRzaH+dzifUaXQh7/wjuUR85lZr65v6z3atwn4wCuagwJEVz1aJWYyzkQ4niU11hQhFe8U2TRkWLbq9tKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxze76bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E148C4CEE5;
	Mon, 10 Mar 2025 20:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638301;
	bh=+UYvo9vFDGsDU6NgUSI0lJczQ7FGUwfcAkWsdmdPEC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rxze76bFCVctH54ZbRbX4oQPXh7wTroFkJvrBiDJtDLWgdME45Xnne2rY0qgyIDiE
	 WTW+CjY0WfoQ3pmPVO/d5S74AHDFI8X6KgM7U1th2MaXUiBr/7OBD5Mmi7Rv5mhJRD
	 fxqvka0JTjzkfvOcyHhRxPl5L6b4e8q8l7oOwFIB1jWGZvBrj0phcLM3xikmHf10Zc
	 xU4icFL7VTKWT5CSE9DivxuUDPTGgwOTGdTZwR7es0DuMqfHJSikbvxKSSLEMSjsUz
	 oT8Arf1JqlgGSDJ7DtYuWq8wASdkwGXXL9WOpC0CP5VGEYXaqqNF4NZt+wUp/GBOoV
	 v3eVbQFaRCcHg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.dev, bard.liao@intel.com
In-Reply-To: <20250310073653.56476-1-yung-chuan.liao@linux.intel.com>
References: <20250310073653.56476-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: take in count the bandwidth of a prepared
 stream
Message-Id: <174163829911.477273.15804709039576849235.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 01:54:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 10 Mar 2025 15:36:53 +0800, Bard Liao wrote:
> When a stream's state is marked as prepared, it is ready for
> playback/capture. Therefore, we need to include the stream's bandwidth
> when we calculate the required bandwidth of a bus.
> 
> 

Applied, thanks!

[1/1] soundwire: take in count the bandwidth of a prepared stream
      commit: 08ae0d61c3d79bb5d52ae30ad4fc12442e966a23

Best regards,
-- 
~Vinod



