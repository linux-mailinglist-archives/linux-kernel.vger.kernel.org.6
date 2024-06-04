Return-Path: <linux-kernel+bounces-200497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82B8FB0D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBADD1C21229
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EED145B2B;
	Tue,  4 Jun 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HqktHl/y"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD2145B02
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499660; cv=none; b=L5dgXtpAU86PKk0ud9EKbK0zYrzgWu1zmWWC4rZ3ACYO0/+MQ+/VFWLd8jLNWtfYbTtxzdOw45eOq9tVKOQkFbgMpzHEF3DRNJSKQyS92QWZ1qRjN+7e2YIT1J6oDcDNFteCQ1H2HEmGNT+y5qnsm90/5YBVmrruCVIozGhrDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499660; c=relaxed/simple;
	bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSTB5Pxs8gNRmJ3W6Pvcm8afEsUoJbIowb0GCHj/hC8N5bo359LA4EGN16O3yhQ3Vn4PlDCKgYkmcES6gWMTUrHcDhWWVFZAlnWA/1WDcNtBUIL8XAbFs4lHAcPHNzqHAPODENPwzKwRCry3EwEpbAdo3H4F30u+OJMbZBFGuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HqktHl/y; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b93370ad0so4071375e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717499656; x=1718104456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
        b=HqktHl/yUJAzNFnAxORkC4KvcVsEvMGytp3raSwv7xvMaX2d97zOkPf3LMZ/CAIKNR
         7fvhHUvuHurVhiTZJOVBtyXZ183D/oJX7INDUNqyBEV8TM9KyAu3X5ifQwKXgjYZfnfH
         3a9OQxmlVsecFCSfUctx3Z54X5RNrMldRaoU2Jx2qj4w1mmj94FimYpUAunyoThPSGmf
         JVvTpN3eSFRFlvviVswHsnXK6Fl6CqD8XIVJ3u7ECvTRKT/B1/HGzmSWiO6D+MvNLeIe
         qVINAiw95Ekf8s/2+8s3JW2/IN2nv57XcqtgBK3rUBSgTRnHWj5HHGCL6WEnGyRmlnai
         G+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499656; x=1718104456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
        b=EHz6RFW2kfeoWD5Zgl7spuK+VzFJ8dJg1apoorlNRErLVwSKjsmOGDXCGY51QqkE1T
         XLWyVZg3lAC/Ba/UB70yfpf9mQNEUAGnekFj+jvfAQgpuprc618ic1HyTfBkSXQ/J4lO
         zyYe8ZC26xt3I2O+wpMuog5uUJ+D6xKANkaPYkH7ADeM+bJu9rlM453MVzzg3fPgPQPq
         D8A7M9YEkoLxPOJScmQxOIPf6sCxEfXDM47Ho1oSsGjsIfkBGhvyCHtcMFfdTBuFaBXk
         SxwtoR7LYDqKTglMCSphue2NUQUwyOFqHdCimuNWNfqxsOfW1+3tUMmWnF/PRyH1Ip4H
         3qLA==
X-Forwarded-Encrypted: i=1; AJvYcCUvydelUt1iC5VxGMSE1XluTyant14IVYf3shJASv3iZCcnZf4wTqUtVKoid/1JjoAFiFo+fJpQ+TCMc9RAlbxb88HnpxUv9J/85IXR
X-Gm-Message-State: AOJu0Yzc/LXteRdw84qLESQoKXgzY8YP385DmwrTEckCZTvlThC2sCQo
	craRGN6vzYTVLvKCcY2IF1/FXMaP4GEbtKkVZjljnLAzGwF2lpm0/vWOQoi57CP1eG9K+pyC3QC
	F+x8Dba9O+s83t4VDuOQkagv2AKwRxmnz0Po6sg==
X-Google-Smtp-Source: AGHT+IGPM+K2hixyRUP9EcOT9Brv7YAnDET3OYQ68QdgVrS8wykAfmjuzPC7P+3Ds9ZEZVrJrtEUH6tY4nUhWlqN5Bo=
X-Received: by 2002:a19:8c4e:0:b0:518:9ce1:a5bb with SMTP id
 2adb3069b0e04-52b896aebebmr8354193e87.54.1717499656564; Tue, 04 Jun 2024
 04:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604092431.2183929-1-max.kellermann@ionos.com> <20240604104151.73n3zmn24hxmmwj6@quack3>
In-Reply-To: <20240604104151.73n3zmn24hxmmwj6@quack3>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 4 Jun 2024 13:14:05 +0200
Message-ID: <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
To: Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Well, I can see your pain but after all the kernel does exactly what
> userspace has asked for?

That is a valid point of view; indeed the kernel's behavior is correct
according to the specification, but that was not my point.

This is about an exotic problem that occurs only in very rare
circumstances (depending on hard disk speed, network speed and
timing), but when it occurs, it blocks the calling process for a very
long time, which can then cause problems more serious than user
unhappiness (e.g. expiring timeouts). (As I said, nginx had to work
around this problem.)

I'd like to optimize this special case, and adjust the kernel to
always behave like the common case.

> After all there's no substantial difference between userspace issuing a 2=
GB read(2) and 2GB sendfile(2).

I understand your fear of breaking userspace, but this doesn't apply
here, because yes, there is indeed a substantial difference: in the
normal case, sendfile() stops when the destination socket buffer is
full. That is the normal mode of operation, which all applications
must be prepared for, because short sendfile() calls happen all the
time, that's the common case.

My patch is ONLY about fixing that exotic special case where the
socket buffer is drained over and over while sendfile() still runs.

> there are too many userspace applications that depend on this behavior...

True for read() - but which application depends on this very special
behavior that only occurs in very rare exceptional cases? I think we
have a slight misunderstanding about the circumstances of the problem.

