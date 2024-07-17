Return-Path: <linux-kernel+bounces-255578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E9934270
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09321F223AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FD1836D8;
	Wed, 17 Jul 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SJYfNj3b"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791C3399B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242405; cv=none; b=FymBs0tkNdm3SbrtBmrXhE0LmsMk3lIRWhMSEVrMlnc9XrgakUatKxl+IYSD4pobPHcMAUxmUSZdd0tuTDYhQs3QvUhKHGNJGkX4+z5+a6rBCPYBEDYtECFbiQRB/HsOK8ct1x0pW8vzlFdnFtrdjLRoXYF5pIRJhpCEwW2heUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242405; c=relaxed/simple;
	bh=Hv0Lv3vxMdF9EUCXQDjKALNMNYcXui+F13OJ3xjzVGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCcOLHmzlvOswA7N6XpvA8q6ONfWtvGSWu00arI8FEcDaR+wOJDHZrfv6zpD8W1dBWc03j7oIrS7/pCjIevSGeM8baFRBLts5U2QsO9+FzvSCKMU5bQMr0Z1KGLYMoXg954UkLSg1m5NOEqAlEQu3CkKUu62Lz2rExpAE8mcxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SJYfNj3b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so208091566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721242402; x=1721847202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMynJxsAoEfgNtqBQWK8foysn8xndosdDwSjU5qP3r8=;
        b=SJYfNj3bK2nMbAHHicYXGHdWyXEcpc4zqzF8MyGTLwTz3diTg1b1BL/K8snXzV5SQA
         L+mi1QyfjbDxhx6/Hesf6rYoupi1zGslPGZO2XLvWsziU3jtZe0OLoZ49RtV1dpTO8uL
         Zu+1V2+DgtUbKgZzVFWTUlfvExGoRSM+MLE+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242402; x=1721847202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMynJxsAoEfgNtqBQWK8foysn8xndosdDwSjU5qP3r8=;
        b=NzhcLaSxW2hQXtgXnR4Vk7rRarZ+p3bwASjaRBvdJkliCqC31KZS9vrxnSYlwptsng
         APGXLtQTqse5MnHYaB9jL9NGZVtd6q08ru1b7Ic8OXPTNFBWGPzkZGIvqz6RQ2xaESoK
         qBEtjiVglnR+N/BmHud4OLxb/NTt3Z4nYCS3CDnJm9VKznlb+3AYpXy7+9bStnt77SLR
         oe9oK+h6h9DlRecF6l1eYoFkMs9PmFnTKXDjcB0fo23n586NuqVH9n+RwhAGmJDrzT4p
         HwHXxGLS3c4ra53Ygq+ynB4G6jM8O5XO+qc6TH+xsWokubn21tFCSVVRdJxMtYrScRF6
         BnGA==
X-Forwarded-Encrypted: i=1; AJvYcCWlI5KEjYSkTMDWxp5CIHJiJeog68/KW9EGM27TSGqxDbmZFYWhWMbh0JoKIyjeooBAEX1sUjmx6RaDeZsN05HJ3/sbKBQNQonapNgr
X-Gm-Message-State: AOJu0YzRrjlfB9vacc/p2EdLudDoO1KxjEPBEgUhV9zkScT/5OEr2wFf
	+A3TcG34KMugfqGnIW7s5mFgC3nSV4SoymjDdkUWNVAFqAP74m6LoWxkj7rCh4k2OALp9idXZrm
	mocOY+Q==
X-Google-Smtp-Source: AGHT+IH7ZgUJdu1brBzieL9VD4Fl8jsFA0FXovXrReYY+uknkDJZyI1CXf17Tp0+rd6PCGYWDK6fiw==
X-Received: by 2002:a17:906:2449:b0:a77:dd70:a161 with SMTP id a640c23a62f3a-a7a0f137be5mr55396866b.10.1721242401872;
        Wed, 17 Jul 2024 11:53:21 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a93sm476605366b.6.2024.07.17.11.53.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 11:53:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so2001817a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5acCJ+e189ZDmn6IJNAPopoItXljmT530S+tcKJ1j3m4jiyxmzBwbfOg8ISH+UxhQ2ZXV1QYY2aTC9WvC2UXOB31iQtGThuaNJaG+
X-Received: by 2002:a05:6402:27c7:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-5a1557cd64bmr545038a12.3.1721242400692; Wed, 17 Jul 2024
 11:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
In-Reply-To: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 11:53:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
Message-ID: <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jul 2024 at 18:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus - another opossum for the posse:

(The kernel naming tends to be related to some random event, in this
case we had a family of opossums under our shed for a couple of
months)

> bcachefs changes for 6.11-rc1

As Stephen pointed out, all of this seems to have been rebased
basically as the merge window opened, so if it was in linux-next, I
certainly can't easily validate it without having to compare patch ids
etc. DON'T DO THIS.

Also, the changes to outside fs/bcachefs had questions that weren't answered.

So I'm just dropping this all for now.

            Linus

