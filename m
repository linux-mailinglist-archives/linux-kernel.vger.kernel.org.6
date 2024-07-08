Return-Path: <linux-kernel+bounces-244071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0E929EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902A31F22884
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF958AD0;
	Mon,  8 Jul 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmwCAmDP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464B44C76;
	Mon,  8 Jul 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430209; cv=none; b=EEafbfoGqoD6s4N0JRAGA+5oZsuh0L/SsF1tMVcc+XTf4kbG8xlMv5whjqnV7OFciM60STsEYH/v0T/b/hekv39FEdtP9w8MYHSe8PejmDl4/PR6g6WpF5pKWuXH5zNdWig/nuFefLrLw1WHTfgQMJIi5tdiaFUdQkBaBALID2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430209; c=relaxed/simple;
	bh=2V4N8nJ37tLEvQApDYOWQg4gMTHKYKHF0mA5M+vKsy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ06hubueHe+0S9EwVeMdnm7WKi9Tc1dDbnn64b+2lXipm77y6Bt2fD5fpS3/dYM6T9jHrK+YSTILlImvO9rcTW79dRnBdv6L9s+/v6m7RaJ7UiZQNaNMQl66s/fJVTURZUE0erVn1ecqZO7J0NAlocz7TeCu8YVVggGXRh5Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmwCAmDP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6a837e9a3so14737025ad.1;
        Mon, 08 Jul 2024 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430207; x=1721035007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFqGm3yI9OnUkznduf63K0BFhweBnxH+Ps1Ldye9VmI=;
        b=WmwCAmDPd26/zo7UVSfb42Q2SawD32iAt9NcOWySWAXXQgDwWMDgFzu8jooxvWJUIz
         3yXw1J8Wo3bb6JdDTjyLosHHm40RNlwYgXFoNgAgBa2mh79tmAw2k0mie5NRxkyUXEQZ
         YmKw0t997Srg1vmzccQdPVs8i7xjq1Sa0yN1EdGM5iof7gzDM3fM598yaLlQahiaoCc4
         yjwnif9lVjjlSv8CXO5QAX+09QIHdv4QY+NqlWCe7/Lgbz618SK58vhRyYVCqicUvGDD
         8LTtXIuy74JoBVjN2u/JtLBz3AwujFIE1jd2rARXMMrYU77bMGNNzxAjj5l8icM/cGW7
         sg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430207; x=1721035007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFqGm3yI9OnUkznduf63K0BFhweBnxH+Ps1Ldye9VmI=;
        b=wlh9W5gxnO/x3pWgAy5a3y7o4Lrb3+rBt2aMAtgDHHftUQqOuV6NBFDg90JQTitAMp
         6+6TaRpK0daSBRX5+m9zsTtegZvRpnJYUvQo4gsJ6y3INFf61nGCmyaHQKe7CBuZgltJ
         AZdRPi9ocmFq9DwlTofVQJ9r2BhPRUus7WQlaFZkae3FBFqCw5uQoORnaAnSMSPnrL+t
         KsY+6NyldHFaxeYi9uQp5ATZmOyRXF1O9TBBa8MNYY5iQW+KiiCnwnVxKWAPZOdtmsFE
         FH7kMroDZ2gP+iPgXNVEq7645eX4kNNbRg30rP5/M/QaIbLRlgInXr67htVGM+AdVrxG
         qo1A==
X-Forwarded-Encrypted: i=1; AJvYcCWt3fhWS92yFWeEiK/klqLsvqjnMS33joGzqqTLuZo6wAG+zAF3cgNjIZcjM+RWld1mLQP57uh7vE8HVfMALs/fsgNC1YvqjdWCP30tIO4=
X-Gm-Message-State: AOJu0YwLc6qS4rqOT+1ja6o0Wo1AoLugYNFSRr1I9lwkzyr0Ue+x0Sic
	r4Q++dX/AbrtSs70McnNo7F7ACsYFx1l7vpv3zz6V49OLsgIGUCiGzQrD5eHDg5FAMZ95Yuk3+o
	sziK0yhJtDxGX4/RDDhuKvL3raMeLb9rZ
X-Google-Smtp-Source: AGHT+IHHKpH+Z/eQxrz/DZkFNJgPRTQXTnAdJWL7jTfHsy0i05RsSYMDvJ4Ls32LH9Fl3i9r2bSsKh54jEz6PCJgzzM=
X-Received: by 2002:a17:90b:2890:b0:2c9:7849:4e22 with SMTP id
 98e67ed59e1d1-2c99c69f245mr6261798a91.8.1720430207002; Mon, 08 Jul 2024
 02:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090615.2267476-1-andrewjballance@gmail.com>
In-Reply-To: <20240708090615.2267476-1-andrewjballance@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jul 2024 11:16:34 +0200
Message-ID: <CANiq72mB3hA6GeN2XSqRpV4m+rCbr2+NLHgmfpphjm1Wo1wBBw@mail.gmail.com>
Subject: Re: [PATCH] rust: firmware: fix invalid rustdoc link
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@samsung.com, aliceryhl@google.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:07=E2=80=AFAM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> rustdoc generates a link to a nonexistent file because of a extra quote
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>

Thanks for the patch!

I guess this is meant for staging/rust-device, but I think this should
be a review comment here:

    https://lore.kernel.org/rust-for-linux/20240618154841.6716-3-dakr@redha=
t.com/

Cheers,
Miguel

