Return-Path: <linux-kernel+bounces-558097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB8A5E1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2239189A2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20E1D5143;
	Wed, 12 Mar 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ED7vGw/d"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B01C3BE9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796343; cv=none; b=BsbLvtvmKsIlC0aYnrQvPPGPbXcTlY1rHmvFTa4iDJFLtMsBaGiiDhticer5JuSEDJbp6Tr7hd4i+u7IafFCo84Imr9Qo9RSZXez9+UtdBzdtgbOpmTOXOJ0IA/jugoLrmajnoTvzvZFZrNeynGRGaqais6jkV85cnG9xIHrdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796343; c=relaxed/simple;
	bh=L+tCdPEuuikQUx15WRiVh8EMMs15WbzGjvM+O08Isg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt/bU0zYzXl3hvQMSu5qCJZmr7H6FrB6D+X/vZzeoOGv8FlR3ApdgLpsbrrj/oyLcYiSGEnI1aPw4gZTP2qIKaHCxdyCx1j6FOUVvQkZG7aArnxk3w6mWi46xnA8awIWBWGuug6OjZd4NYqh04rP9oqcnyVQOxdGU9foq5MW9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ED7vGw/d; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22403cbb47fso1046845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1741796340; x=1742401140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+tCdPEuuikQUx15WRiVh8EMMs15WbzGjvM+O08Isg8=;
        b=ED7vGw/dsDck8oU4NR4oTljZkiLdGHxDVfs5ZSUKj/zqzhJzibms9Nc+3w8oMboA8f
         FeGdzqZfTFFke1N0wZpHst0a9Me0KgaNlhT6Xh+dpLaSeDFw19sGoAorK24zsPfc7/lX
         71nfCsF20HtOJTr4E8pVIjZlbdHvCirxAYnj0AwxiXlQwLh/zh9/G3rxzOAbmtdIfHW5
         IH91yZqhOvhPdA9eIkP2Eb5hFwGdFw3Ukq85cfsYKzAoT0DpKyIYKsmaGmt4+t2+DJxO
         4Xqns6qsSuCQd4bgR5vfwUkz+brINPOBACHzf4EIt149uqsi+0USe7APbn9+lDLFUMsA
         L4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796340; x=1742401140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+tCdPEuuikQUx15WRiVh8EMMs15WbzGjvM+O08Isg8=;
        b=jon0/6sMX+A/5Rd9h0CIrPYRsSnRtGQtFA8kGWYhRgBVXsWTJxpYmgrZx9cfY6LKtN
         wCzEC8fppxaOQvEWk40jdP8Q7n6Y/MTe7M7Q7GXqpcTb0qdWqS5yZHrsEYI5SnBaW8hW
         thh9ryKps6G4yKwa4/O6OUJ8S12ZyXpLGDFUEOk8biCeEtlg8xJ5hP5pxY5HZ8YLpTtE
         /BBW+q1mIt8Bl3ZHsQbvKUaPpbsrNshkQrztnIFIqIrasBX/GKvQMCcHaxuskGoULTUz
         5bl0X6Tm5h27PkQv4x4MLOiXDMwl+TXhR6J64yr/ZSJ0pQqYGhxdxYWZOIYP+3UWiwJo
         tOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWMq0HN29kosjlOwvHNByW7Fw2rNH5M8arFeUEFzBCzQUy6AO1PPpsfXuMkxnzYuxYy4yJ6Ctj2tEAzJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNZPbeDiz4k+wQhwUvzdyeCpyBysrAC2oNMAOHP/b66YqPRP8
	9zR12BVNsFeGSIN5pwammqUrjmwaFD4qdWlle4NqjS1SnZJcCYUVWMRzMnkLrzCtXuE5N+9BEc4
	+rIKnzIL8yhO2q92NQ0WidZEvGB9PcG+4+7FuQHah9qTYhkxkOaOk6A==
X-Gm-Gg: ASbGncsr+cO4dCzsJYG4JYpHHVTYloT8VwcyEXUmdYiedI6II3OwOHxFsgxnoaGYzUP
	HB4ZQlJSc75eC34YqxCJmbKxRF9jDFCp3QeKpGsLf2OtQAfeIafGYuSSUed+ItNorhDxIqecKTQ
	IZU5GCtn7ObVv6s0/RBQxTeYhmHg==
X-Google-Smtp-Source: AGHT+IEzeuirJ35v06ZpAeCoudNyX1zllB2KPEQvNHaaKY5Pj8xsVgMJdPGEEnKMVpmZE6ZPTvWiNCfmIkBRzSIqmt8=
X-Received: by 2002:a05:6a21:4cc2:b0:1f5:8220:7452 with SMTP id
 adf61e73a8af0-1f582207511mr17977801637.24.1741796340554; Wed, 12 Mar 2025
 09:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
 <CAOMZO5DaZbRXuv4vgWk9evNcV4iW6gXy2Vjv7oWsnMo_R9ku4Q@mail.gmail.com> <CABqG17gS-kiB73tTC+u-TER2+ABLYPDVM5YyjiqpEzLTb0LbJQ@mail.gmail.com>
In-Reply-To: <CABqG17gS-kiB73tTC+u-TER2+ABLYPDVM5YyjiqpEzLTb0LbJQ@mail.gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 12 Mar 2025 21:48:49 +0530
X-Gm-Features: AQ5f1Jo-5_CpGz2sBHoLxcb-8mpPBzuC8RFH01rncuLzB1k6Cv_o42kwes_3CuM
Message-ID: <CABqG17gwNJnn89SwJf4xAMWGjz+tW+7GkQZEj-D7dPT2Ox9=jA@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: Fabio Estevam <festevam@gmail.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, 12 Mar 2025 at 19:37, Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
> Hi,
>
> On Wed, 12 Mar 2025 at 19:32, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Wed, Mar 12, 2025 at 10:52=E2=80=AFAM Naresh Solanki via
> > lists.openembedded.org
> > <naresh.solanki=3D9elements.com@lists.openembedded.org> wrote:
> > >
> > > From: "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com=
>
> >
> > This From line is incorrect.
> >
> > It should be:
> >
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> Correct. Not sure why the tool picked it that way. Will check.
Found that I had set the author name with the Signed-off-by string.
Will be fixed in v2.

Thanks
Naresh
> Thanks
> Naresh

