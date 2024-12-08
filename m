Return-Path: <linux-kernel+bounces-436331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF409E8485
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD831653C0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E33142624;
	Sun,  8 Dec 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hagFVAcv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB22130499
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733653251; cv=none; b=JBwhjcLInl33W/PVaqYBFWb/c8Lv+CHQ7cE8qlOX/zOSluTrjB9K0x7ah5XGiaqqs9FwEK5eybhgqE+fZk2Isf6a/6S8BCnzsXyE+O+4vMLmG6oozdRVtIWfbEpb0HWu4pP5qyTIqrGGRSB4YgX9hu1BBqpykB8fQf5YNAfy6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733653251; c=relaxed/simple;
	bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNo6MeeqjmX13+AZchigtGuiHLXf3NSzw7ZEJcGwRH6GB00sTxG7LrZiIo3f2Ihyd6noNity1wD4OEGO0rS9n3dJ4rkB255pLXps7eKHMzPriG4iMHYDxnG/yxMRIBdwF1jw/21VZKp+Bs39R1BOANI09S2+Ncor6hJB0Yd7pzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hagFVAcv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa629402b53so434809866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 02:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733653247; x=1734258047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
        b=hagFVAcvlbOeZ+9wVigGAAC6ChsShJHi1HrXZ9ZTPn1hhUjWgNuox+qvj8eEeyybHg
         35OYnEvgYVQ/jCNnlks6Cv8JpJF5wpeqpqjt3m0rDjWspZrujIkQLD+qzSDYbHuiVWu5
         9YH/EflQBqot9Oyb4j3U7r/C6vaShaBGGEPE1w4NWrgqnE2PTLVPgIXPDgNtDxGk8G5S
         X41+l1UZ9yv/BAuJignKohlQl1kG8NNbhpuGSjDV1MxrVWAsrixELp9mwVBo+nvhI4zj
         1rYMC4CU3bjs0wUOknwmd4BjTOoQq/5AvNErJ1hrvaftKXHSiL84H2/qpiAu76jZ4okL
         qEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733653247; x=1734258047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AslVg5GZai63noZK1hbCUABgi6fZFg3OgTktJsgI4U=;
        b=jtBUKdbjWnhazpISGkztBmLR0z9rI06YVIUG/DdgCOjXEAhJvyDgPirT3xpKP+b+qa
         VJ29mqamiSQ/8Y+ZuUsY9OL1UAO9vdndt2Y6tQOl25LskVVJnMuqoXVKuJ+2nIJQs4JK
         CAX3O21qelOHeUiTr3BTLIHiw/SMCjx3a2jN1BhWIal7g/WfNfOu0KRkdX5+oDc6PcFi
         tbG6XmPMnRvxgUXmek6Vl5plCJqmUqTcM2Y3x/z1VyhfKWx1XnI0l/bkEGdAxDSyPt8c
         JlfX71RB2qqWbFYx95yv1aj3ShzTA6g2R2JtUE9fEJgEtwPEWvtLOnukJaI3cEF44uCM
         qoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHtqsLRy3REs02GSLF6MxYezJ09EFWjjffDETOltrSQWqoMvXYVgGBWtAxWliz7lbEOaptQbboQpTv1aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jJBaubkRiZx2Srx+m6s/Oyf3TbdoSZet6OmIWkJj50Nvf5Nu
	UzDJa6C/P7oErmW50AO2po8piJH9fnGcniKrxDbmokox9u2AoiSKod0K/l8EFcxfzgUTu7+Mc2i
	w/EApkvW+ymMMPVPSWryPNlQjdkSbWGeDdTtgFA==
X-Gm-Gg: ASbGncuAxPPLBrOmMI/jU9SbFbrNKFu1n/gv4W3uNjAIrXOmBnTnQbCoBJb79Q5/uzR
	+x3hkgnCGvgdWmy3pCFOXa5fnufMScBUK5PYeAL+1/H7AsBXagajttRYOlqbg
X-Google-Smtp-Source: AGHT+IHhsFb/p+bUKWhNb26BKnfksM/ayxxLkaw2zAoftdh79YIZEReweI5txI3aE/Mh13JN6jNXf17waG7w8+NuFdE=
X-Received: by 2002:a17:907:3455:b0:aa6:3b8e:e07c with SMTP id
 a640c23a62f3a-aa63b8fbfa6mr604208266b.54.1733653247478; Sun, 08 Dec 2024
 02:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
In-Reply-To: <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sun, 8 Dec 2024 11:20:36 +0100
Message-ID: <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 7:39=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> Here's a Brotli-compressed trace (of 6.12.3 +
> dhowells/netfs-writeback). I can reproduce it this way:
>
> 1. log in via SSH (cm4all-lukko is our SSH server)
> 2. "cp" a file on the Ceph home directory
> 3. log out - bash hangs inside write():

Today, I took the time to bisect it, and the bisect arrived at
first-bad commit 796a4049640b54cb1daf9e7fe543292c5ca02c74 ("netfs: In
readahead, put the folio refs as soon extracted").

