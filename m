Return-Path: <linux-kernel+bounces-284988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B19507C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728C628493C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9E19DFA3;
	Tue, 13 Aug 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUfWLnfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A1125AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559608; cv=none; b=isk83GWv2Wn2drTKe4K5nKliGGF7D1L+JCHDzP4SVkxhAinVO/oSI8eFhCCHnpVXKYX+TIipvkQi+XRqN7f5PrlEnexnjUfVSwmzrNn8RcKF8zobBsyVjT13e1S/6XuQzNt+NwHbjxUnxst6HQObafATY8P8syLHTSBA189WUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559608; c=relaxed/simple;
	bh=3a6mRuAjt3jIt4YRX2DWO332ocA6zv8y2+Yw3KbG7FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZL0oNN1xg5Sqmm4dx3uQjQxrSmlM1uW80OUsW2qiQcrK6hk8277TO6BB+dR6UbF/XiYVRSdB2MVkr1mtg0atlLAPPtzDQfq5/8hJaTZzI/kRZMdiH+2Dx9WXCA9+Ecipiqqlq8WYwPOIQxj1vWnoV1rNdFzArWO+kBWx1CLv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUfWLnfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E37C4AF0F;
	Tue, 13 Aug 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559607;
	bh=3a6mRuAjt3jIt4YRX2DWO332ocA6zv8y2+Yw3KbG7FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iUfWLnfG8bNGd7QIFpHNn6S9UB701G5zggTss4wNqKyd6g6F1qk2ziwTav9jz4BF2
	 OjilPhBCr5rE7/MjXrlL9eHesqGEQi9uIECrgGYSmJChNaOWcugFxm7+bFh9UlQWd2
	 06gjYgy/WiBPRTk0IRDwY6kC19B9mvcX9i1AbWzA2QrzYAVVzEoU4emS+DjEUvSk8Y
	 +Y5f9FQMaGFM2wb4K5OPES2TlqAw8zH5VmoIxWN+E/wgPZz6hWLQQDy8tqEVYbhLD4
	 a+4BI4EUQlE+58dD2KmCNIodh59x0gapma8B+e3OQMifg8B4Te2mgwBnXfxCjPZdC8
	 oAmZFAZBjFj9g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: add Zetta ZD25Q128C support
In-Reply-To: <20240804221535.291923-1-mwalle@kernel.org> (Michael Walle's
	message of "Mon, 5 Aug 2024 00:15:35 +0200")
References: <20240804221535.291923-1-mwalle@kernel.org>
Date: Tue, 13 Aug 2024 16:33:25 +0200
Message-ID: <mafs0mslgze4q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024, Michael Walle wrote:

> Zetta normally uses BAh as its vendor ID. But for the ZD25Q128C they
> took the one from Winbond and messed up the size parameters in SFDP.
> Most functions seem compatible with the W25Q128, we just have to fix up
> the size.
>
> Link: http://www.zettadevice.com/upload/file/20150821/DS_Zetta_25Q128_RevA.pdf
> Link: https://www.lcsc.com/datasheet/lcsc_datasheet_2312081757_Zetta-ZD25Q128CSIGT_C19626875.pdf
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

