Return-Path: <linux-kernel+bounces-522413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649F9A3CA09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB97017C1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38747241128;
	Wed, 19 Feb 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XVEwtH/q"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69D23CF0B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997286; cv=none; b=VWND3dmE0ZnsN7lXmNsNlOTSMNwKCHWc37PlPF+D+409+PgcQgpM0bek7rN7jYsYuTvBxwVlJ5Y6UrMR0eI8lKyyzC4erR2MU3U2uDGlQyvugio/xChahxTAUXfRovaEZhQ+kIg2oL6xAmroC/3zlbNLokSsN/hB8OFSBgPAmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997286; c=relaxed/simple;
	bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0vg1Mtj68P3yT6cdJitPPnpTklDouSNwwWc6rr05Kdg3P7+zKsU4cq3ggs1xb5gQYdlltVbDFUHdHd8VMY42hCzGUUUD82LPfuNfXW/8mIko0zNEE0kZoeXiMeDhaCFeBdbE9ZYLVjrZmla1XtZhhv6AjzDupp9uY3MB2Rr3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XVEwtH/q; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e573136107bso230820276.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739997283; x=1740602083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
        b=XVEwtH/q3uwtahemtZIZYeVgKt2oPwscKFU1Ma8Fa8b/Pjkl/G6QTzN5W19YmDZGUr
         L8OPMduNH/bepK7iBePi7EJYxObBXWUSD+3pgcVJ7O6FNAYYhHgZ+E44WuLQ80k/dHQy
         J+FJr1wDHF+uTNt6rwyzIKPjUd89QCAkphiKLZiWR4HeS6TPlX82p6kcTsLFB8oIn9TV
         aZ/5KRF1prwWkJUKByVqZX6dnCax8MS153Vzc9opihcJs9vDSfExdMFTHtKV/fxIGjWX
         JHpBCaly0Za5g1oC0oXzSWxwwp3TSYKlNRFRMxe1nH7RzGdFR47JXdfpylDsrZEF6U0v
         AzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997283; x=1740602083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
        b=YnUdcoJGUX6WOJ+7+S/9d5ZYJzqvlzlAbOvaNSok/wzUUu/7AjVUKfjQCfUywXKc/V
         ehsGyJrTK8eaT/ExHVjMOwsZcyb3EXI5Ej4vt3taWoOwg8LbFMVks2nl+/b57nMUmQyr
         4t+c0i04qMj6/N/id+wyaiOoNsJ3trMlOj++xUBvIkkLoyGYqnv4kMStojLszcECJiUP
         6hyZ4Qfy08lS5scRyGrN2rUkjSbtkXJ0W7FC7XDMnbn0CKwBEUXjT33ngjPk1iJnu9/6
         WIPCs0AfWABOYy11HeDpgO8l9VL3X+gyVVVNCdAyStV+00vC23zXmtJ8OlHZ07ZfQHpC
         KpJg==
X-Forwarded-Encrypted: i=1; AJvYcCVq7d5R/eEEJRxNNMpEosUgCJf/ZICVFLCxc9MzH2BVXkKKTpEn8i3/MaClNv6m0Rwm2Mb9v5b9SuwVQko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzhBJDnbzRBTVTeRY/wJZvtNCTCEDbPD5y8ffqRDly0dTw0gg
	NfD1uLvdbbJmCF0FUmMd3Ymgf0OzEOcF6CF4P3Lkhz/B4QKOdlpnLMvxxoW/9QAKtP5G42hJlDN
	ftROuExgCBsXf+XemZRgdx98iHn7oh/88VI+TuQ==
X-Gm-Gg: ASbGncvx1De6JwTzAaj+RO7CvjM6DhZ+koOwb2+zqE9kqzcoNSy+7jFzRWbvqn98sgg
	CQ62Yo9a/G7BYdFJKGXQAmNhNGwtomgIJmHfgozA9K7OHQnLrAQAukVC9ZuAjjjLdYdGj0mg1
X-Google-Smtp-Source: AGHT+IGePlpcMLMtkO0p0cMKs45EJcgHTubpVnR0FVFgPsZCN8wY2WvKVp8xiCuIu+uMpB2IgJhvErQ0UfEdqhRd4gc=
X-Received: by 2002:a05:6902:f0c:b0:e5e:1433:d93d with SMTP id
 3f1490d57ef6-e5e1433d9d8mr2320341276.29.1739997283704; Wed, 19 Feb 2025
 12:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
In-Reply-To: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 19 Feb 2025 15:34:31 -0500
X-Gm-Features: AWEUYZn--jUstxIYkGocBKiiriYS1hZyBvCJukvbSsj7phyx-28qwZS8FcNku2Q
Message-ID: <CALNs47uJKvdL4r9r=4iv6Y1TJn93aizOfXYoPCFc2ifwvSyTJw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qt2025: Fix hardware revision check comment
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:42=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> Correct the hardware revision check comment in the QT2025 driver. The
> revision value was documented as 0x3b instead of the correct 0xb3,
> which matches the actual comparison logic in the code.
>
> Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

