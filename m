Return-Path: <linux-kernel+bounces-303576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269F960EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4811F24B99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD151C6893;
	Tue, 27 Aug 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nl+gl4D2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F31494AC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770368; cv=none; b=GtvR2MJ0QqFD9jYhCphyVRbPqskJ5mryses8NlJUrzGQwr57uzMxYzjemeqtT3QmeZ2ynXdFVDEM92qYLAT7ubOCz+DvOFC4/jJkiXXVYs/YO1U/aqjuxBPa4R7ru++tPzGLKDdhGxErH6a6eDNN70CPx9sCZUcJdor5nHphV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770368; c=relaxed/simple;
	bh=FpoF2mSEMlHyx8TXOhSx8bKH5UwMZ5RhXRXLzjwLDUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isFy+tF3GTNOwsHQDiTSIaPabGHfMvmfHoJfjqnxE8Nu1Pc5ARtnwkODr5aNCkntay9xz5E1eC7fYWmuNprYwagLNyhz9q8PiuO6sUJQ/sIRNKFp7oAufrNWyOaQYp1ic01VLsOP27D7SPABtExLx4XnHPdQ3qmk8yNkZY1b9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nl+gl4D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE0C61042
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nl+gl4D2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724770367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7qcNQiqpvYyrsOJRgCZJ3aKzWC+mK81NIUC+cyAqHQ=;
	b=nl+gl4D2H/7sghlVPRbLh6Axdqp16gpxZvBXoqX6jayCpP/zUpn+nGkLAvWOSqJTDBMqC9
	5/uR9nPCGFzI3iTAz/4NDWFn6jgHgecsHhJgj7qMK0Bc3Bu7xWYHgxZwqexj4rybYIyWMY
	Owzvnjk9wkYv0/8h49q4eH1lfBOINHQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 180abb00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 27 Aug 2024 14:52:46 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27020fca39aso4712506fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:52:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQJnLvfL1MjdNcPhJmO7ffeuVgfGABWXGbjjZY55BFT6pYDpIH
	/pR/VpPaYFgWYlz/7ry3b2S4E4U6bMWuKP3CuBiUD2HnWtImBFdCnfgJSSEQQHj+8wDr5jKbgW+
	vr3VhKNpTAgrFJIpT30IDdBx1Fxk=
X-Google-Smtp-Source: AGHT+IFk85VhrKqyMz967RiBLv2WMJSmS9NTA9UsDIrR01fRhiYloyQh2pBBTjq/YHTPzXcLeAEBASnT2UIXcmNbrc8=
X-Received: by 2002:a05:6870:9727:b0:25e:eab:6d32 with SMTP id
 586e51a60fabf-273e63df52amr16119848fac.5.1724770366034; Tue, 27 Aug 2024
 07:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d9c376c-10ae-40cc-8d8a-d614b8dd289f@linaro.org>
 <20240827144200.3315093-1-Jason@zx2c4.com> <a333f3c5-2bc2-442f-8a27-7ec0d6380de8@linaro.org>
In-Reply-To: <a333f3c5-2bc2-442f-8a27-7ec0d6380de8@linaro.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 27 Aug 2024 16:52:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9pX-C8OhyaLOWLS98=TnAHjiWSyT+HtwXx-mAZqMEz-DA@mail.gmail.com>
Message-ID: <CAHmME9pX-C8OhyaLOWLS98=TnAHjiWSyT+HtwXx-mAZqMEz-DA@mail.gmail.com>
Subject: Re: [PATCH] selftests/vDSO: separate LDLIBS from CFLAGS for libsodium
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:45=E2=80=AFPM Adhemerval Zanella Netto
<adhemerval.zanella@linaro.org> wrote:
> >                                        -D__ASSEMBLY__ -DBULID_VDSO -DCO=
NFIG_FUNCTION_ALIGNMENT=3D0 \
>
> This seems to be wrong '-DBULID_VDSO'.

Holy smokes, thanks. It turns out that wasn't needed, and neither is
CONFIG_FUNCTION_ALIGNMENT now. I'll send a patch  removing these.

