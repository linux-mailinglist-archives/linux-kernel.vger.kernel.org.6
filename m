Return-Path: <linux-kernel+bounces-446236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBD9F2190
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B621165EF2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DEF1862;
	Sun, 15 Dec 2024 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GJYR2PW/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E59819
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734220990; cv=none; b=TcQCDyT9xqhh8AiygK1CvriT3+vTjFNnnLkuY0Rxl6tlyEV615jHfCI/Wsa5enwmoIZ7Ia8JT5UmNmN3rlQaxXkpeKW1+AXZXzAiTzYMJkqscNLJO6IfoDyHBLz60Shhj//83SU2rZeXbQhJ0+PO53IH3t+HG0q2kduUi2FTgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734220990; c=relaxed/simple;
	bh=xQFkpgBPg4Q78xCiadfJSR1zWL7V/gBsQiInFrVHHm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyJBlVDEk8CD6KTWtWfrAXCcSCBHDqEKUYF6NmQa/1Vq9LMawTJG4Au7PnXkso2c7toyNMVuR4d1fjxIzi2m4607UujTsw9FvPTPN55ByMmvzOljYx0i2h90SNS2YK02nkSbyXKIVLm1OBBFMdZRzrebaIzNVOfekdBgCfI+4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GJYR2PW/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso497932366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734220986; x=1734825786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3usN9VYGUEh24gR+LciJgIyFJjC0v6UAg/jDOmx3oE=;
        b=GJYR2PW/J2E9gcF7loKLRmwX8qNvIdQ9IBY0mcQ+w5gpcFCu5jwPoKVIycf4IkmIzO
         m/7112sqXk8cYeEO2HY/RIMSGIM5MHPJjrBPVdgNjhg2iZwzJRUT3TeHvprnS+ve6Qkd
         k77LCdH9OCnm0pL4fSGbKAvdelvogQs+MtntQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734220986; x=1734825786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3usN9VYGUEh24gR+LciJgIyFJjC0v6UAg/jDOmx3oE=;
        b=eaZjDtTF9zWhU4UMc5/qQv84meSU+Rvq3goyEE2RKma3rhFMva0Q2qo/1TL07g2uNW
         84ybKsXhof97cRmjcyYigYxkmtpAFQruzlgBWL5uRuoUY7sAkgGXeUuy4KZtcsisCQ/g
         dkmbdzLmJzEQ2igK2bOPXbPcFbsqjaDlvgFlLjAplC//LWHRvOZG4045/jUjUT/+Uyc9
         3xJ+IhFjWiNxBawEOkggzyRCoPrX05w+PgtUE8/mxEdTbtd0ZXPFk6R1beId9e+NgFnq
         XBVub7e9U4NzG3Flo70dK4YO5g4+V8fdo182KwTGTxwmY7OLX+j4sH3OLlNh3aq5/Ugc
         ETJw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmv6XYFtuyf8ud4L4exfPcMsqZ9OIQK7/rgXz4GVuccmAo9w/vaC3oNQ6RwDJbyCuvMxCfLBB4w7SpIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfaunljPEjwglBbbrnCnuxL397CAJEHxaGHknqtWuVdhZ7LBJ
	FUJqEUGvyDvXYQazsbFtYGR2sWahZ8eNfvqGSVMYOyllyXeV2BHso0unVhrUI1EKFTYrzXMtKI1
	DBgQ=
X-Gm-Gg: ASbGncsQ2LJvD0nMFRYBI9Z8aE9MxZbNgpk5XKYUzb90i5CU7w9esSFwTiwYXHSZIjt
	p0AYV72RrRq9fCVOIsZvjzBEISzDP+ERIXk1AWiwWDPivTVYhiSICvuIw8R244wJPIGdySLWRfi
	IeGjawdV6JsVpnrtPhh/rTpf0jQ3M9PPNsBBeiXxxvU8sAgWQSy9TxYJirYWADvL2KtWBqv75PL
	N0bPVoD7AI7LPEivyNpaR7CkKYjgqProVqtIuGU9O4UbmnMKkkQVYhAXcDrWyDXTmxVQxxLrYxj
	IuxWszKCeOxYE5FQ6YWMrLMEWcVQYHg=
X-Google-Smtp-Source: AGHT+IH5KJ4hpMQo7zIWjfgj6JenAK07cVTgTeoUDFNila8bLSaGz2DAKnBTvI/W8JO9pvfZl3uLEA==
X-Received: by 2002:a17:907:1c8b:b0:aa6:7cae:dba7 with SMTP id a640c23a62f3a-aab778c6ef1mr833443666b.4.1734220985965;
        Sat, 14 Dec 2024 16:03:05 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963599d9sm149504466b.107.2024.12.14.16.03.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 16:03:04 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso497928366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:03:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEdsGZUJcfDMP+QdvGECTID0esIbJ9j89wjoW+SXno5OMRIhbqPhoVLbMbTEpBfuxQ0iglf0C58LSd5dU=@vger.kernel.org
X-Received: by 2002:a17:906:c146:b0:aa6:82e3:2103 with SMTP id
 a640c23a62f3a-aab779b7e12mr856494866b.32.1734220983343; Sat, 14 Dec 2024
 16:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <395d805645f141b15ef818dadf39c8689986e8b4.camel@HansenPartnership.com>
In-Reply-To: <395d805645f141b15ef818dadf39c8689986e8b4.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 16:02:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUTLUdiyc=+Mw3qTiQRu5xhtkBYd9r+o_hJTKgoW9XKQ@mail.gmail.com>
Message-ID: <CAHk-=wjUTLUdiyc=+Mw3qTiQRu5xhtkBYd9r+o_hJTKgoW9XKQ@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.13-rc2
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 15:08, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>       scsi: ufs: core: Update compl_time_stamp_local_clock after completing a cqe

Why does that ufs driver have that pointless "local_clock" version,
when it also does a real ktime?

It's documented to be just for debugging.

Then the "ktime" version is documented to be for statistics.

What makes this all make sense? Two different clocks, for two
different non-essential uses? And that duplication literally causes
bugs because clearly people get confused.

This particular bug has been around for almost two years, so equally
clearly these timestamps really *really* aren't that important.

Can we just agree that it's silly *and* confusing to maintain two
different completely unimportant timestamps in parallel, and just get
rid of at least one of them?

            Linus

