Return-Path: <linux-kernel+bounces-189022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFB88CE9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D4F1C215B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94194C631;
	Fri, 24 May 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="cX3UtwcX"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B974AECA
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575953; cv=none; b=Kptp8Z9prtiY+1+2P5YdpO4VT+V0E9Sxop9qNEhkwTUoajNRHW/YjAnG0QmUy97LGhMCahCN0up7d6oDTVb6XuXt20wPMpwAoxqf5ZVCn9BrCxlhUkpV9hb9GT9NjQYZ89LpcY9Q5Kl2Z7HI9Zv47Le0MhDipNgqjSXEcWfnxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575953; c=relaxed/simple;
	bh=4BWDlFzmKgPu7pIeN9TGO2G9NGrk4rFNS9672TWXGuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtDyq4pLEhGahDVGweXJl+bBiCkveckXVNWLredQz5iT/WWHKgU+YaB1+rxG6tq0D8RBn4Ap1J8hS4eHH/Ch2266bQkOkfOD32X4TXKoL0RHeVLxGdbjV1sCxyLRKMeiYjLDZ4nTU0E+MU/WOFaWkZraYxSAxGkr53Gw7SN+S/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=cX3UtwcX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df771cae64aso1257469276.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1716575951; x=1717180751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BWDlFzmKgPu7pIeN9TGO2G9NGrk4rFNS9672TWXGuI=;
        b=cX3UtwcXQISd+LmyOvOu0+o5LjCteXrUajdcN0ijCjqCmvhKIgyJxFFbZKMtu67x+h
         5V91tPnLg852WRijF91ImsoFchQBcf+Gw8okv9bg2Iqcz2QcFc2S7pS6HtxSqn2sPetC
         ZyAMsp0cPrcR7pgFCb6OR2OXIR+Z3qGEUdeZPkgpPF2ppBy83Xo/96UcinVsIxGnRl+i
         E+Z8O/TNke2Q5RQaKL9CF1juYQtxVzf+32LXRQOsT9Gg/tECMAiENmYT32QahCgzVre6
         a0QSPEj/HXro/bghZnvEDUOxnrS9C2ri3Q6Z3lN5Z2INkh6RSQgXxZQV5R5+G64kph7K
         n7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575951; x=1717180751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BWDlFzmKgPu7pIeN9TGO2G9NGrk4rFNS9672TWXGuI=;
        b=OYYRVRZHNKRMMxLatCX7DY4fETN5uK4MgGAeChca9nhJ8GcDiVruhQ8Pqq9lUy/NLp
         jbabcQPV0+w6bHhmwiZrTBS0c4m8TzmpZXB/F1FBEnrW8KfyaCCooNACOeOgv13PIyQU
         dDmu+K1no41p753Qp5iltQktvHvmkTbeOAqA4EgYsJZbhlcrfPuCixXswYXeLbQtYlSG
         bz++Hi7DO00lNhN/aY6j5WNUcOXEGiNKCpmnP2NYb9lx2GbzVuYaiVCX2zshe7JXjcoY
         rEzIsFzFSJEhiyxLuSvJfKFmZrUx6yt7glP9Y4TJpxGGXgffZhzNr4kp9Dgy7ZFH+eVR
         6YJA==
X-Forwarded-Encrypted: i=1; AJvYcCVml6CfnlRwn6mmMoP8zyWRgXKjXMj1G0hVEbf8O/n0SjgSvLt5cvMhUa28wA0DvNRyKcNy+DI68RBBUJvLkwSDNbhSn/UWQOGrgeWK
X-Gm-Message-State: AOJu0YwiiUV9ceOg8t3puaXRtZT2jX4fbssDa8D5tJaidDsFTsevF9ej
	ejm7PVUkTbYf4ZK9wwHFjZf9p1rrahqlfftknL2/36br45bghsvWblflxXaNpTDrg5/vffgU0Hw
	RN8PBxAU6u+02cvr8YgOSRU0mkPsW+bEULCFI
X-Google-Smtp-Source: AGHT+IGySwby0Wi3hsPE2Ha/40Yh/i6YxdkBaMZS0CGt0TCthCDA2n11AkgR+AfJ1Wsm10vYyVXwWIN/nMtZG/RaeNo=
X-Received: by 2002:a25:943:0:b0:de5:51d0:9a8d with SMTP id
 3f1490d57ef6-df77237535amr3114332276.55.1716575950805; Fri, 24 May 2024
 11:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515055631.5775-1-ben@jubnut.com> <20240515055631.5775-6-ben@jubnut.com>
 <ZkscFnmHeWWma7Nb@google.com> <87jzjk1ibr.fsf@jubnut.com> <Zk_63rrDJFhN1Y1q@google.com>
 <87cypb12j9.fsf@jubnut.com>
In-Reply-To: <87cypb12j9.fsf@jubnut.com>
From: Dustin Howett <dustin@howett.net>
Date: Fri, 24 May 2024 13:39:00 -0500
Message-ID: <CA+BfgNL7RGWuFK-M=Cpt8nLfroK+Xpqtzs4nQ1Bwnv6iiVd5nQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
To: Ben Walsh <ben@jubnut.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Kieran Levin <ktl@frame.work>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Mario Limonciello <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:35=E2=80=AFPM Ben Walsh <ben@jubnut.com> wrote:
>
> I could add a new quirk which provides an alternative ACPI match table
> to be used instead of the default. In the default case the match_table
> will contain only "GOOG0004" as before. But in the Framework EC case the
> match table will be "PNP0C09".

My biggest concern with putting PNP0C09 in the direct match table is
that it would cause cros_ec_lpcs to be loaded for *all* devices with
an ACPI-compatible embedded controller; it would likely print an error
and bail out early on, but it would still be unnecessary on 99% of
platforms.

This is my misunderstanding the driver model, but is it possible to
add a second companion device?
d

