Return-Path: <linux-kernel+bounces-220400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5790E12B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A2628225D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF107470;
	Wed, 19 Jun 2024 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtPi9qxK"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEB6112
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759748; cv=none; b=kQ585/y0XzHRqQ/2Bbdz8XiFOI0aKsHl9Hp53ssndVFqtu802Qym25xIfm/pTmuyqFAqjrRqsUAV1GBl25jAq4uD5GVUDkqOTfTAfAtb/VNpHmAhskHFFuEsaVxFOVYEUFWF8PQyYAs5Bxl2SyH7jrWidt3WpRR9HRqhfpsuvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759748; c=relaxed/simple;
	bh=wuhpJWllzquyP6xKZ60kyLvUqRhn+Hv4ZzsFsuIdsGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8aXJM2yxdM7MU4G+yvM5EDrHGaT2McbolRvI1Q2TCKEpplH6/C89OGfyOZDaX8/e5Gy1LLqoxYGu0Dl8pyaRkiwdoZt2/EMwxXvtczXRudNki3rJ1EHPbNB6Y8W4ce/K8kQwcH4S2CX/Ng1FurSEwdS4IXEJW0YMflo3CYiXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtPi9qxK; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48c52a1f1ffso2512018137.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718759746; x=1719364546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jto+2KBAammyuRDteQwTTwC96pLpNXDsN1v2Rc0adi8=;
        b=RtPi9qxKG3aFdK3x6ljEB2Zhvo2ofSTv0OyV+dc1Iba4mJHq8yET8a/vvPaIAiVPe0
         B8oFl4d5ts5k5QeoZNiZ4RwRMXbGISApWQz4kKPA8fE/fe5nGoCKXSOoPiWW/lhGOJDS
         /uSjXO43rMWAyC2ow7TNME5rkEbcy422FrmeJ4nHvWMl+/V4gGojXCcbUDiE/3c3vLD0
         iXUJWy8i+F1m3OmCz+yNiNX/RPNz0/fY5iCUaz2mNUxVD3AqvYC4pDkwoSv2IDYmYMMs
         nSHHmxzeGFqdlDRerN5yWGy4HJUovWxxBS2Rw8BSxV9indzOTnaq1As7/nvKu4U39siU
         RwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759746; x=1719364546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jto+2KBAammyuRDteQwTTwC96pLpNXDsN1v2Rc0adi8=;
        b=nibWdRN4xXZ927Vz9XFazb/RwbIryxwS5qC+8uqw6PHEEH1CJtJnn4RnFVC70fKPwy
         6/BDotHqYMmoXRoTHExqkqucG/0wi2s2vUlS+kByBAnD/ixs0TkR9XAi8+yt6LbbaYCV
         QBF7VW9cpHjZllKtQjwW9A+3m2yGVI3QRZ0j4jJKXBUyDmYQfCpvR3qA2xep5RhKRR7s
         oh2jDhu+fgY+BSg6wcedfqDyhzb6NEmyo3/QrkaqCOhs3JaR0IKSE1fupevgckXD0nOc
         xQXVWz3Ei1qj9O0ySIyPhLHxerQ/sLi9b+4DkNNIvuFbxsSd+11vKeW8I3o5G6RWVJa0
         ZZqw==
X-Forwarded-Encrypted: i=1; AJvYcCU0cOh9xaWDr7+B7X+t2CQ2lAaW4DFUrirFaJSeiAhDw20gYt9DA51/wFSzuRLCZLmhOXyOLnm7oMFv/kWt5AIsmqEhghJMczFPHwmx
X-Gm-Message-State: AOJu0YzJxb4BLzk2phZNHWXO/KL0vIDCTUggAsF5RLrG0xXXYbtq+f4j
	A7g58/RD+eNvJP1WC4dvnHvH4ar39cQP2mhWyCNZKTyWDB1gZouT
X-Google-Smtp-Source: AGHT+IED2RB6niiAooYbdp9OYgJJykph+uwJBnmbFgzm6IbLsEA5q6INPNth1DNzRWj7t4z3iqiZZw==
X-Received: by 2002:a05:6102:1610:b0:48c:3c3a:55a4 with SMTP id ada2fe7eead31-48f13141063mr1547541137.35.1718759745754;
        Tue, 18 Jun 2024 18:15:45 -0700 (PDT)
Received: from x13.lan (2603-9001-5c02-c5bc-0000-0000-0000-1b5d.inf6.spectrum.com. [2603:9001:5c02:c5bc::1b5d])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80d89295847sm2004918241.34.2024.06.18.18.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 18:15:45 -0700 (PDT)
Date: Tue, 18 Jun 2024 21:15:43 -0400
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: dushistov@mail.ru
Cc: gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ufs: Use LUT for dir entry types
Message-ID: <ZnIxP2nxVaqNPbPx@x13.lan>
References: <20240610034219.14711-1-luis.hernandez093@gmail.com>
 <0485dd2d-488a-40e9-b0f7-24236b9c00ab@web.de>
 <2024061008-granddad-aspirin-4208@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024061008-granddad-aspirin-4208@gregkh>

On Mon, Jun 10, 2024 at 10:00:18AM +0200, Greg KH wrote:
> On Mon, Jun 10, 2024 at 09:48:09AM +0200, Markus Elfring wrote:
> > > As per the original TODO, replacing the switch statement with a lookup
> > > table results in more concise mapping logic and improved performance.
> > …
> > 
> > Can imperative wordings be relevant for another improved change description?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc2#n94
> > 
> > 
> > …
> > > +++ b/fs/ufs/util.h
> > …
> > >  static inline void
> > >  ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
> > …
> > > +	if (mode_index < ARRAY_SIZE(ufs_mode_to_dt))
> > > +		de->d_u.d_44.d_type = ufs_mode_to_dt[mode_index];
> > > +	else
> > >  		de->d_u.d_44.d_type = DT_UNKNOWN;
> > …
> > 
> > May a conditional operator expression be applied at this source code place?
> > 
> > Regards,
> > Markus
> > 
> 
> Hi,
> 
> This is the semi-friendly patch-bot of Greg Kroah-Hartman.
> 
> Markus, you seem to have sent a nonsensical or otherwise pointless
> review comment to a patch submission on a Linux kernel developer mailing
> list.  I strongly suggest that you not do this anymore.  Please do not
> bother developers who are actively working to produce patches and
> features with comments that, in the end, are a waste of time.
> 
> Patch submitter, please ignore Markus's suggestion; you do not need to
> follow it at all.  The person/bot/AI that sent it is being ignored by
> almost all Linux kernel maintainers for having a persistent pattern of
> behavior of producing distracting and pointless commentary, and
> inability to adapt to feedback.  Please feel free to also ignore emails
> from them.
> 
> thanks,
> 
> greg k-h's patch email bot

Hi Evgeniy,

I am writing to follow up on my patch submission from June 9th. The patch addresses a TODO, "turn this (switch statement) into a table lookup", originally introduced on 2005-04-16. I believe the original commit message body may have not been written in the correct form and wanted to offer an improved version:

"Replace the switch statement with a lookup table (LUT) as suggested in the original TODO. This change results in more concise mapping logic and improves performance.

The ufs_mode_to_dt function now maps file mode bits to directory entry types using a LUT. Indices are created by right shifting the mode bits by 12 (FT_SHIFT), isolating the higher-order bits for indexing.

This enhancement simplifies the code and optimizes the mapping process."

Any feedback or guidance on the patch would be greatly appreciated.

Thank you for your time and consideration.

Best regards,

Felipe

