Return-Path: <linux-kernel+bounces-571161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A46A6B9E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC60189EDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6820222582;
	Fri, 21 Mar 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+7FmkuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871F22371B;
	Fri, 21 Mar 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556473; cv=none; b=u0gTbsuq6M5sDrwI60RqbTOYJ7OCeFLAeWkdif5pOJtb03WhHY089by98FzzPNdMSJO9lMbUB8o8NeWv+x+znbkLrSSoscHdzBITTDJApBsKbHLZ58BIEmkrGPJDs7AiVntBsn0X1xytvu4hiUtcLfW/ovG/G+4yhseS3Mxjy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556473; c=relaxed/simple;
	bh=c/wGSFJOfYXlMyOqzLU+K2iw5jrJZeHx2Bg2ojMHeEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P1BSoJebzGuzdObHXs7/TxYMVcwSvCUMN6/L5JuEBdG3KzGjWAUbrvaXdEJ/PNb7gOx8TQgnVCRP9BXtKr+FNe6A4SPxF+M/OMUfyfrV0nfv9tI8ONkJ9g63wJ4++/U2PZpUgOmD8erPYUVhbkEqjFpfelqSrwx3LGJzDCduYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+7FmkuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA7C4CEE3;
	Fri, 21 Mar 2025 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742556471;
	bh=c/wGSFJOfYXlMyOqzLU+K2iw5jrJZeHx2Bg2ojMHeEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H+7FmkuI/GZPcZaIJhYqQ7X0vVxUYzLjbSrz0q3bwLavBimgDa0PwVH1JEmySlMG5
	 R5nRLNTiU/xZBvtOUPJbzaKnwm6yy6Lv00Tt87nDgns3aSOzCMuKZjcu5vb/vFL0su
	 ATHvJlYTjv4k1yvLWY0n8ld4B7xPSFk3dG++V2T5XgoGsiRIFgkZMxsukuqwtwIipr
	 3AlCJAOv/huo1tRBz2Q96b2dTyO3HdlobblNdLjoXCFWzduwVaPTQpZSjTroeiiMrt
	 U/4i51aIbDQ0U8XsusvozJ1YDVkYXcfLBm2lm7WoBT7GNG+pdKps0yUNJzhFyDjsH4
	 VyMUCaDxYE4qg==
From: Lee Jones <lee@kernel.org>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 linux-doc@vger.kernel.org
In-Reply-To: <20250203-congatec-board-controller-hwmon-v4-2-ff6c76a4662c@bootlin.com>
References: <20250203-congatec-board-controller-hwmon-v4-0-ff6c76a4662c@bootlin.com>
 <20250203-congatec-board-controller-hwmon-v4-2-ff6c76a4662c@bootlin.com>
Subject: Re: (subset) [PATCH v4 2/2] mfd: cgbc: add a hwmon cell
Message-Id: <174255646961.2088064.14807499273570643972.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:27:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 03 Feb 2025 12:01:06 +0100, Thomas Richard wrote:
> The Board Controller has some internal sensors.
> Add a hwmon cell for the cgbc-hwmon driver which adds support for
> temperature, voltage, current and fan sensors.
> 
> 

Applied, thanks!

[2/2] mfd: cgbc: add a hwmon cell
      commit: 6672baa795851fac209135f2ee24643280e1d017

--
Lee Jones [李琼斯]


