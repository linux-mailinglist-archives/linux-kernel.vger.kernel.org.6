Return-Path: <linux-kernel+bounces-419191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5029D6A96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ECB1619AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6696A13CF9C;
	Sat, 23 Nov 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IT4ULZFo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FE7CF16
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382966; cv=none; b=V8e5UNIehMmSbNqbTKBFBLMEpkP2jyHyPHFIZUEnLtbNGC1KiA3kLTT41Z8KljnXfoG5d13V2jzRZ9Z39Pi9fwn7sd271CxFdi0VW3hepZ8OuCGJMZ8LbrO3NlI3JS6REkd5P8Uuy0A7A7/PPwCCuyGOKD6NMj+3EkyC1nvIusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382966; c=relaxed/simple;
	bh=JW0p9SO4wNjvfWYrh8A4OxTL6/rZR0ph+y4ILjPxPlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9CGhZj+b/Cgwaw72P6mj59ZXLPUZO7Ft2BHGjBpydvnok3rxIYujFUDGHUVNRUE3IEI6k0qoIrkQ14/DebXs/u3nIUqBCVsLxZjB1fIp5qw6OhyzqeDTejFWl5l38xqaacd3Lsm/f/cnhd7Wq9Lynrr1H2ADx1XE4LblDkmDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IT4ULZFo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa5302a0901so101087166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732382963; x=1732987763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vCmemIQJAyBLtyohdE3n6qmf1JVeKEXVkWL++xifbs=;
        b=IT4ULZFoN22WvQ1hq5DfvRLu3WXEGh8N1xg1fHX5h99lox+dpGJu1qwIL31ZTENh6j
         ZKTkRz5Da3gOftWVyi4za9L66UGp1xcjqasFTDh21QXNCI67y3tAY2gygLjIAzh+u+QE
         kCI484fBTEwyoX84YytSMetUx/G5dzpY0LNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382963; x=1732987763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vCmemIQJAyBLtyohdE3n6qmf1JVeKEXVkWL++xifbs=;
        b=eOP7Px+wYEVgnN2oTGx0XTgGaSUAGtyn6p2x9TFWhWUL5q5d3iRxb0YNXxopiXbqhn
         yr5SKuTNUvpJaF86PtJ3Aa3105n6963H7Z3Wejev74DGTzroDA9nWNZ9WGoWF1GEJ+9m
         xIHJ12SV8N1ffwpOSKgwWPSCJmnxRh7zxQbmyxc0wBlPG2WO9QABMXaCm1ep/wQNrQZq
         yLbZ8pbIuw42d6wdSj0jyi1vZJlW/pbjXVk4SoizROJYIn64+87Mt7H8G3+b7I8mMdaj
         aGcTYo7ik/nHGOVDtVoVtUDS/casKrVHvjvYVjtQ52nyK668ljZsm3esUcLp06AuO3m3
         NOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjOrGLsbYsRIJcfm7OYuDN3XyR/MCsg+U89v8SFRS1nv1skB/ZsCxbHniQliXwojCLMwEz+XiTGbUkTKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVMX9uyKsJbIKkVNccUcOhdxdbghjE6gxjmZrWAeqYCxbTlUy
	5EuxJY2VUt/KGnO2KnnijqEZAtloVV6gxYrkFFEUpve6gPLxHi0g4E6536Y5Y/A6doKMzyWtpRd
	5d0ndlw==
X-Gm-Gg: ASbGnctDCFPcPEWvQvPpmApIMhgNWOPnxorpiDU17vXjroh76LqrRz+lgix00RZK6qO
	bo0Wd5RafDVk9q9v563rAxZR7aOBrgAZRJeoCemX62fqqp5m4BvmVKq6BNSNtnQQS7KXP98IuqP
	8nWzbXZ8bF4M3Vz/ZjDIuYZIyfDQ7sSVKmkNSD5DvULvSyVW3kfam48KCbqgsRlq10kOXSS/FWs
	TghKTi63eYaPVEl15frdPOoN3uwypGUKHphiPLeRceaSdX+4iipKHJROZQeuezrwQlHR59ovwPS
	SgKw6JeicCEQDxbl+RIJEVAU
X-Google-Smtp-Source: AGHT+IFzJwIS1OZajPFMYj5kv/yiFWp0nZJOmcIChwfa6dvXlEA7oIh8ULyN6ibByu2lADDAgQbhNg==
X-Received: by 2002:a17:906:310d:b0:aa5:40b4:e9eb with SMTP id a640c23a62f3a-aa540b4f49amr73560066b.12.1732382962926;
        Sat, 23 Nov 2024 09:29:22 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53b6bf286sm61160966b.64.2024.11.23.09.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:29:21 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa503cced42so277464566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:29:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTfsFCuMXuwCBWpFmHcHqJ9PQ362ZIMwwjw0m0ZIS2HbeTgdKTMTZz83sbDHHyCUq8G83r8ohfzIuuyeE=@vger.kernel.org
X-Received: by 2002:a17:906:9d2:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-aa509985a54mr597055366b.36.1732382961227; Sat, 23 Nov 2024
 09:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <20241123-bauhof-tischbein-579ff1db831a@brauner>
In-Reply-To: <20241123-bauhof-tischbein-579ff1db831a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
Message-ID: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 04:06, Christian Brauner <brauner@kernel.org> wrote:
>
> So just to clarify when that issue was brought up I realized that the
> cred bump was a big deal for overlayfs but from a quick grep I didn't
> think for any of the other cases it really mattered that much.

Oh, I agree. It's probably not really a performance issue anywhere
else. I don't think this has really ever come up before.

So my "please convert everything to one single new model" is not
because I think that would help performance, but because I really hate
having two differently flawed models when I think one would do.

We have other situations where we really do have two or more different
interfaces for the "same" thing, with very special rules: things like
fget() vs fget_raw() vs fget_task() (and similar issues wrt fdget).

But I think those other situations have more _reason_ for them.

The whole "override_creds()" thing is _already_ such a special
operation, that I hate seeing two subtly different versions of the
interface, both with their own quirks.

Because the old interface really isn't some "perfectly tailored"
thing. Yes, the performance implications were a surprise to me and I
hadn't seen that before, but the "refcounting isn't wonderful" was
_not_ really a big surprise at all.

                        Linus

