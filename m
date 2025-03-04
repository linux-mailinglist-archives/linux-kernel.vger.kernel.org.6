Return-Path: <linux-kernel+bounces-543898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B664A4DB57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9616D3B3B57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22093200BA8;
	Tue,  4 Mar 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="fOVEFEYP"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC21FDE29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085039; cv=none; b=W3hgDBDnzl9XPauxO/VAEo6FKwvn7lj/FLTayrB+0i6t3rZvY9iRIEpgF+ezxid6E9D/r4zp8RwYlBLH2ymv9JXvhPwEyQErYZUbmGIxXoPWAO1vE/HiMLBWFyHpH5k4qCewWBp+zC5fXlEU1MAldTSYVx/JU7E+HFwS/imxOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085039; c=relaxed/simple;
	bh=amQpJWz961G9i8FxpA0xFOpFzhTcMDLimCTtZwpNAk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWhQCDuLj3hqwFjhxdiWVeNYXSGlfQe2MRDcZslALrI79+daasueXsBpPxkTQUdQbpqDTKl/jNHYBAeN8OyzMIamDxJio1t9p7R7umKjtN5f7Rb2F1uFzoDr5pYjrJeZIbPAmbqeETIijoSTCEvbLkc+LKq9/ISi6gJXHx7u+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=fOVEFEYP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22349bb8605so104372355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1741085036; x=1741689836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amQpJWz961G9i8FxpA0xFOpFzhTcMDLimCTtZwpNAk8=;
        b=fOVEFEYPm+QV33iE0IW+3GrB5IYDKiwJFbYzNIq2ngpFllzDj9pPo39mVwKuGTzc8M
         t70oDkECTorTEAl+dmAHEfxBV2vvkOKoGkkx+cS6ASGtSYAk6BsvKYufAzcjR2wjTsV+
         1JET+wb6HETGcjhYggCkK/6g6MCKQy5xZlQUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085036; x=1741689836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amQpJWz961G9i8FxpA0xFOpFzhTcMDLimCTtZwpNAk8=;
        b=e8d2gkAkAQ1KzXHQAiu6ceX6NcmNw1ZInXS59bGmoX+q8D0XZ7D+uKsFBBmVWf/zh5
         t+QLXqJgtVL0E/L0NLpccQu8a6r+rsZ8ZfZjQHaTNjzDeMnitH17CescfYMMC2W1GoJa
         Qd766Cmke+Vc6yDfA4U4AFWk5qUB778mIaY3QXlUZoD4h9WXNx+wEZRVcQIjvXcStqrS
         dXpZWKFJIK2x+Svx0dGDCQpx5RBOFDlIX8P1SZHMEQR4TbWKnwElIPJ5tnwMbr+fQmCb
         Z7BKTb3d2P1PMBbOPRHGkgPV1o1XO7L9EAfYy2JFo22yIIIrLrZpMXbzXxipYEfk+9Gm
         dmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Q/kqBuklmrpoXfRXiDoBPYPnMeMa+ike6fwmULvPwDEw4g5Nq3awloQoJ1Jnl748XxtAvXiNCnPZ1js=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHKAM8rLiHOIy+lAY/++lv7+wlAFigi1+Pk41piQwIRAxMzgV
	jxSnr4iip5mMtzeMxP37o4FzbHC03i/EIfAGduWNsjjNDg0bIpqYueuX8fhykYn8xEEbIaYoGoi
	NFNTuxwxjUFeGUrYMsu38Fv2XxZSkYvftanVBOQ==
X-Gm-Gg: ASbGnctSwduQlE01/6jcFclLHg20uBTr91Y5dGQc8HSpiWVutI0yrCOJGFzHNHc/n3e
	OYv6prwbQLRRvPL0D3qEXIzeTLBT83sXkPHUNMTNOPVfmHLSJoQFseX5e1uTHphWwt6rJzYag3e
	lIGwy8Fcq47TTqrHWVXEsftlrNjFRPZTZ2wG/bI+lLFCGWf2HlvW7aBC9lowyq
X-Google-Smtp-Source: AGHT+IFO7ecXy741NtL0I6Bknif1mhVYH09bLzARVHy05PDJewQLqqW5mxJi8Ja12tOhLHjlqqbqvh81sfRC5OXcmc0=
X-Received: by 2002:a17:902:fc8d:b0:223:44dc:3f36 with SMTP id
 d9443c01a7336-2236925eef4mr279799845ad.43.1741085035767; Tue, 04 Mar 2025
 02:43:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105071433.3943289-1-daniel@0x0f.com> <291d1541-e026-cc50-6a55-42c11c64b6eb@linux-m68k.org>
 <CAFr9PXm4kTWF27GPMNDb5=W8vZRQia418xOQDF_X1yo0vwn6hA@mail.gmail.com>
 <4eb796cc-b178-8394-0149-03600f1caaed@linux-m68k.org> <B5B5D58B-D111-431F-9701-44FCBB67D11E@gmail.com>
 <b33b072e-f44a-9450-cbe9-52300ab971a3@linux-m68k.org>
In-Reply-To: <b33b072e-f44a-9450-cbe9-52300ab971a3@linux-m68k.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Tue, 4 Mar 2025 19:43:44 +0900
X-Gm-Features: AQ5f1JpSY7K1FkOyRmqKHCL8vF9tnRQSANhYqoMuATNBZDnqfwF4WOLBi9qLGtw
Message-ID: <CAFr9PXmXsW=RqJsWPCUDvQO+vst-wSj__Fi3nuxCo7ZRAi0wOA@mail.gmail.com>
Subject: Re: Bootloaders, was Re: [RFC PATCH 0/3] m68k goes DT
To: Finn Thain <fthain@linux-m68k.org>
Cc: Josh Juran <jjuran@gmail.com>, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 7 Jan 2025 at 09:57, Finn Thain <fthain@linux-m68k.org> wrote:
> Some of those bugs and missing features apply to EMILE as well. IMHO, what
> EMILE really needs is a MacOS GUI like Penguin. So my advice to
> prospective mac bootloader developers is, add a GUI to EMILE rather than
> try to maintain both packages.

FWIW I have started to move EMILE over to using meson to build (so
it's easier to build on modern systems) and fixing up some of the
issues it has with building with recent GCC.
I have it working enough to boot HEAD on a LC475 and on QEMUs Q800
machine. While the penguin ui is nice EMILE seems to work well enough
and it can be used to generate bootable CDs.
I have a setup now that can generate a bootable CD with the kernel and
a buildroot based userland that I can drop on the SD card for my
bluescsi and boot into Linux without any macos intervention.

So basically, for 68k mac I think EMILE is the way to go.

Cheers,

Daniel

