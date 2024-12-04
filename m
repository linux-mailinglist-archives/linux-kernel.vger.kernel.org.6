Return-Path: <linux-kernel+bounces-430481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4099E3169
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB81619CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA638DE1;
	Wed,  4 Dec 2024 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoHELSPh"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFB4A1A;
	Wed,  4 Dec 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279417; cv=none; b=OUmUexim3ldBS/viRtKNfBwsD9B5/UG1mtXc+gectXBoA6GIlFtkTI5anMuGYItJVK7Bi6Ud3NnTdyLU/3KxuABO2Qi2wJDkpGIg38UfqRuCgBn+ITWEgRFCADlj4ZCu2BAEN71WaPBniDm1+anqHgCg8ii1LdGvDnRBs2I/bAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279417; c=relaxed/simple;
	bh=TkML1wd3A6nrijWYmjiPifcOFSF0bOEPG/gMs9sM6uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAnuiIAgrB4gloSrq48R211txSq+T1lSP3R5SNGs3OnwyfI3V8nNo7yQfIRyZpyA2Sb+vG+544dkJ/OnkyQekLXv3amVZSOyBXP08Ze2rboAMBMsgLbyhBBOvZrCt3/Y/slXdoVCPLjmtuxa1fkjnAvFGIaOe3Vf3JaKVUukBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoHELSPh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21583eec308so4321775ad.1;
        Tue, 03 Dec 2024 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733279415; x=1733884215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkML1wd3A6nrijWYmjiPifcOFSF0bOEPG/gMs9sM6uI=;
        b=JoHELSPh+4bSb7rBzqplRl/JPbynIzU+aUl5O9j/Nu0QXTTos89Sse9cnTZlOpo9sl
         lU1cBxpKNWm0Dk/IqKqR3u2jycsCpfxV8iuAwMRDlPmCn+we8GEvQMUEu7a28qu0EM7C
         n7jPPuHiPY3uimt5n7Qj6rU9MU3PWLdEK6nD2iHuScPDvlAH7avKKVkDYtrzPGPZrXAL
         JKPddA3xeU0r3AXwYr5/I8tjxk1UBuH8EQ9/S9yKEt35x7nhBLcDuuSI22tQaQg0CG3Y
         SdXvR6SWwK8P2c7dICf9d8ol3kwSZTM936OHFCMXum+aF/cGG0QjGnIpgJ53JNw1uFlx
         2IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733279415; x=1733884215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkML1wd3A6nrijWYmjiPifcOFSF0bOEPG/gMs9sM6uI=;
        b=QZ5gETqaXRDHOVqYzf5SoAjetOX+g7PX8QEVIy1xGlaBHDNxm1fwgg2qMiu7BYh54s
         0WpHFxR3jvDaNvmjgi0GaYUalzDUs3Ns/RmwkaRjqJTB8231JgYrO7AVJ/V5Fye+3tRC
         AhHtS1l8rPJoIDQJqIjx+0uLxwTR1JON6UDRJjuYnJITxg5CBRiw2y+IvQzB928p3Vwz
         IFxC2WCXFAnWp2KkbrKdnQBQf95I2Fq/8hmPrSvqUuqZQjQS6NJtkpaOwINA6H3Q2+cJ
         w2U6j+CXfYrmruHm9m4voySBlkSfyq5RqFP4HChll7etGKIfiFJyfRlDlDOV43gNhzIe
         5HRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOrei1QgSfI9GfNUITqKTIcY6c0VFF24sognbi1d6h6dIBACC6ojjLh6hwqLMUEU4AiEv1rqvf2wc45fWJVs=@vger.kernel.org, AJvYcCXSIztl4yntykbG/8U4Rd6gHmfA36fbfT17IwZRvdCBVNAZKZL96vaolACmRB7rAOnrq2TDQcTbt+yGw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ubSokt4jWG25T1+NmnarZRQ85YYVz+lnsYpnQmWotm1g8+lV
	VQFjlOQkVvL8nxqRUIQisAGR+p8uSLRL2BoufsplIl5GfNCEwI8G2hfAGOoayJ3lp1O0SZra4WJ
	oml5lwMqVOmyMRlkbNZOVDOkoTyo=
X-Gm-Gg: ASbGncsBbEi3DIJg/hBebjVRv2mf5sj/B95AO8u7tVXW4xwq9AgTg9eC02dER2Fy3OO
	v58uhGC/ArZfITISJlz+4xDYWa7x9abI=
X-Google-Smtp-Source: AGHT+IHic2zv8qoOFI8sT+YJKvRg09ySS7SrTpOeSgPj73Z0B/8oFUixNvGCq60KY4H4WNgnWM/k+1z/WHTamhHqY6A=
X-Received: by 2002:a17:90b:384e:b0:2ee:a00d:2ef8 with SMTP id
 98e67ed59e1d1-2ef0128353fmr2582457a91.8.1733279414987; Tue, 03 Dec 2024
 18:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
 <20241204015711.635816-1-jtostler1@gmail.com>
In-Reply-To: <20241204015711.635816-1-jtostler1@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Dec 2024 03:30:02 +0100
Message-ID: <CANiq72kT-BEBrbe7LHajc2OcDSfnEAFQ+pu=ko1_KUhbs99x4Q@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
To: jtostler1@gmail.com
Cc: alex.gaynor@gmail.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:57=E2=80=AFAM <jtostler1@gmail.com> wrote:
>
> Looking at the documentation for sending patches it's unclear whether
> the commit message for a v2 of a patch should be modified for cases
> like this, or the only changes should be the in patch changelogs,
> after the marker line. What would usually be the preferred course of
> action in cases like this?
>
> Same as above about v2 patch messages. Should I add it to commit, or
> include that in patch changelogs?

The changelog between series goes outside the commit, and is meant to
help reviewers see what you changed (otherwise they would need to run
e.g. a range diff and visually inspect it). The commits themselves
should describe the changes in that commit, ignoring what happened in
other versions, and it is meant for the future to explain what the
change is and why it was introduced in the tree.

So if you do A in v1 and B in v2, then the commit message of v1 would
explain A, v2 would explain B, and the changelog v1->v2 for reviewers
simply states the A->B change (i.e. briefly) so that reviewers know
what happened.

[ Sometimes it is important to explain in the commit message
nevertheless why an approach like B is better than A, but you would do
that in order to clarify why B was picked, not just because A happened
to appear in a previous version because it was tried first and
discarded. ]

I hope that makes sense!

> I agree, I think adding a third where the length is set to
> `isize::MAX as usize / 2` illustrates how when `len < isize::MAX`,
> the overflow can still occur.

Great, thanks!

Cheers,
Miguel

