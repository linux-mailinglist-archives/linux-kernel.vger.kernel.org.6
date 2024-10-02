Return-Path: <linux-kernel+bounces-347652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14198D8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1271F233C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C31D07BA;
	Wed,  2 Oct 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHqshu30"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE031D1318
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877711; cv=none; b=LCvDype+MRsIrN6tAUhwCpanXpyhupq5hz5vrCAJcvXCoUn0qdKePtpi/S/bEDN0UJm2O8rGf4zQlpt7RfkDljG4s/2r8C1yMHa9R6cm+9I3d18fWRzB0hnbvfVYcpOuUH8KZ5TMZgCK4cpsuyvPNcUmL79p57Byh1BsihNVOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877711; c=relaxed/simple;
	bh=1pmb1sDkBayL7SpLFra03BlTRS8TALBgSPNxfcUCWr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/gFhwSs/4G+IF0pQtg0aKN5hKVS4/83hQDsbfMcCq96lSbL6p9BQekJxVbI6riD8M/w36HVnhazH9qM87e6EoetC5tKuwuuWdof8PkYu0Q/F9W7ygu1iQcFx46e7anOuwepEsz3fg8j84zKE3NfRS54YAorRTcEPafVTXFnNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZHqshu30; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so8323487e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877708; x=1728482508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pmb1sDkBayL7SpLFra03BlTRS8TALBgSPNxfcUCWr8=;
        b=ZHqshu30MKhy+ha4bqlsyDrTwhplZwJfVZujK9mlWbbhg4xD+qG5exJM+NLfdGo9zB
         zheBlVXOc/h9hNDUPKu3wMRs03Fs0BXMXdzTXIbwfmnQ9J818co0Lj5VQ6jIGOL+wjN+
         pEgyBUeouMOxCzy86dPMDLTIaU+zGuK/GmK6k8KYj3QCMxI2VYlaUNRqVrZC+7LwdKl/
         qC8VpWX5FAHgnGagaJyjmZ0AmjkJ1rs7BmjNwDbTYlIEDLiNByAVz6OI8QvQhUxlPxTC
         TrmasBFfeoj2sBOtHwcd/Nhh87iX9AV+Nb6SrOA3OGPbdRJNSI7goRhNOmD8rsYcik6c
         JMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877708; x=1728482508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pmb1sDkBayL7SpLFra03BlTRS8TALBgSPNxfcUCWr8=;
        b=AuS536+hcCYuNQQcRejPPSf79DlRt657kuSj+IRYHCLzsnXaSAD+doyu4HopcqECKC
         y64+aV3HpDaHgCx17Bg5TBHHIzTL9AQYi+aHsu1EWpxFgkVkOTDVFRJ1eTL5bnOEf8Ue
         3FiY+4QnkFsAg97srmHDtxRGkWbD41cVGTrKO7tBKnIlgU2tlYmZT5/K8cGqI0iQ8Ri1
         HFXfrfxcqCzKsgbx8vXvsrDzQSwwrUvTKIEnLuWGbGnjC9HDIt3g2KJ6vLHGggbPfKba
         LHw5zjFwBOQ2S8R6A8+56hx+wJ3Ls7YVeSGNvZzsZvnc5YPbi0qACZZzRO+aJrDO45pc
         TgYg==
X-Forwarded-Encrypted: i=1; AJvYcCXpHYW1GPTaSPOwnirzSvTeJvO+Bm/PPIR2Fhp9UBYkDP+cdBBgEEWUhlsrpvBd8ODqBWkKIKpLjL8sClk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUXFNy5B2a5L/3aY4RafbUDItbHHh0QCHrFOsINvWuqaZTk87
	x+AvLRLiykKTPT4RQZJ7laK0bYBBo3VL5gO2mN/Y48yIh4mTdFdybgfyUe6q8Q1MhQs+maEvtZn
	bcOarSeHZyLi6F5vYaX7Vnc3Ecgc4kJ4CM1ExPg==
X-Google-Smtp-Source: AGHT+IEW35z+SB32dXETmyauiAuNdaSBG8Cnz7/x5oVp37LUBxxVnzuKhCWcA0adW64UvBqEawl9nsr4IE3RS0Lg9+g=
X-Received: by 2002:a05:6512:3192:b0:52c:e3bd:c708 with SMTP id
 2adb3069b0e04-539a0658abemr1776489e87.10.1727877707635; Wed, 02 Oct 2024
 07:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001221931.9309-1-ansuelsmth@gmail.com> <20241001221931.9309-7-ansuelsmth@gmail.com>
In-Reply-To: <20241001221931.9309-7-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 16:01:35 +0200
Message-ID: <CACRpkdZ=QLcqNrynWrWn0oRxjBpqWDko8rw95idEWvyfw+xEOA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] dt-bindings: mmc: Document support for partition
 table in mmc-card
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	INAGAKI Hiroshi <musashino.open@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Riyan Dhiman <riyandhiman14@gmail.com>, Jorge Ramirez-Ortiz <jorge@foundries.io>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Li Zhijian <lizhijian@fujitsu.com>, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:

> Document support for defining a partition table in the mmc-card node.
>
> This is needed if the eMMC doesn't have a partition table written and
> the bootloader of the device load data by using absolute offset of the
> block device. This is common on embedded device that have eMMC installed
> to save space and have non removable block devices.
>
> If an OF partition table is detected, any partition table written in the
> eMMC will be ignored and won't be parsed.
>
> eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
> also provide two additional disk ("boot1" and "boot2") for special usage
> of boot operation where normally is stored the bootloader or boot info.
> New JEDEC version also supports up to 4 GP partition for other usage
> called "gp1", "gp2", "gp3", "gp4".
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

