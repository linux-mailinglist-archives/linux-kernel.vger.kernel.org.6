Return-Path: <linux-kernel+bounces-331748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC297B0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D57B210CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC21741C6;
	Tue, 17 Sep 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PAh8hq3p"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB322905
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580054; cv=none; b=G5mYkehqds7ivUxx07ylodNGUVG+74ZjfzVZbvmt2yaxycnEO8lv5+BbFPp7/mFstGUDV1ZnEcvNZbLISZ8g653tt/jf8O4A1mCGgdFNwEcqxqtMhS+MTnJCqnE4iotKzV5oYaB081Bh4VH9ZbWvfm0IgM+7sCtLysZtVLgyfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580054; c=relaxed/simple;
	bh=xapSbkB15yBGDb/b8xi7mboGbXHaNBC77NUCFzezhRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXYyJaVvWW+T+1nyWyhW6oOBH6jizj0YNQg596vvTsR4NWfqMgAC2n1AiECQMIc+zVpWgpIejTdxuOhSAjDiKdml2x3JKiO7MDwWUg8zIX7Ykv4tcuCqXBJq8wo538KuwZ8GEnBw7JP2+5hg5sDef0lDRjd4697GT1pFAgW5Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PAh8hq3p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-536562739baso4621208e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726580050; x=1727184850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=upZOcbcM83/tWZmHC9AfIgF0EAGkag8q/21dK6zFMtI=;
        b=PAh8hq3p44bIjpTmWbjZCKwgjhTwU3PvYpHUkwNgERB6YSG+Cl/Y9q32IWfr8eiPYG
         kPkpQMVu73fcjwPhDmqnF0okjkUWDCOHFhSJrYZ/KtMM0u9TMOSBr46EzwcPqHKV+39k
         PLqg5C+AIWYcPVb1ROaEwyaqb2d6z6OnZs5wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726580050; x=1727184850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upZOcbcM83/tWZmHC9AfIgF0EAGkag8q/21dK6zFMtI=;
        b=jfT/A6dK2qGnbaAazozst94k9JlgCG10iCn0xmmjCFjDknEeNlXHSQYhLb5n9BzoID
         5/wdU5zIJDlyZB3uiKUZhkrtBlbyX9yCRA8IuG3bZjpV1XRL5/Hs3fCnixQmHJFTCYa9
         xkUbUCohLidLbayQMseNuwP5YTyuCawNVUM54ta4qjKe0pwJlsQ5n+nU0f5ohyaddgR3
         Je/14gF5ULXPx2inG9Ks5mVBUWRlUbiBYMk6jd9ugRI12mKEO/4GYT1MOs733KufS/nA
         lCkiFLDBTpugdIuZUAmH4NLwi3F+0TgjZe4d+9e1OBOQlcHengcmPV+gjmDGMYiOhEET
         MyqQ==
X-Gm-Message-State: AOJu0YwuA+Oou+9Es9x0LD87BVMAyDPniRmeFhQDul/YCRscYqRp66sz
	cnFtFxCTQhTUAv9woXsrcDfNagSvhRch7oaRwszPFNe4Houy0RSuweSpq4fR2aHmva6+xLjUYwZ
	DhCbs7A==
X-Google-Smtp-Source: AGHT+IGJxZ7Feugazmufq3/iagID0pY0k1InVWpa58wrbwHh1DG/02rMMiCOW+6/RII4sk2Ew0BJ3w==
X-Received: by 2002:a05:6512:2511:b0:536:9ef3:3b0d with SMTP id 2adb3069b0e04-5369ef33c0amr50649e87.2.1726580050030;
        Tue, 17 Sep 2024 06:34:10 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046734sm1204271e87.58.2024.09.17.06.34.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 06:34:09 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f762de00e5so63727371fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:34:09 -0700 (PDT)
X-Received: by 2002:a05:651c:556:b0:2f7:631a:6e0c with SMTP id
 38308e7fff4ca-2f787f44858mr110363371fa.35.1726580048686; Tue, 17 Sep 2024
 06:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172656366281.2473758.10766953231775492818.tglx@xen13>
In-Reply-To: <172656366281.2473758.10766953231775492818.tglx@xen13>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Sep 2024 15:33:51 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi3MKD9_FQaKijkFLJhUmZCzat+uuswoWeG-NMemjdsVg@mail.gmail.com>
Message-ID: <CAHk-=wi3MKD9_FQaKijkFLJhUmZCzat+uuswoWeG-NMemjdsVg@mail.gmail.com>
Subject: Re: [GIT pull] irq/domain for v6.12-rc1
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 11:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Two small updates for interrupt domains:
>
>   - Remove a stray '-' in the domain name
>
>   - Consolidate and clarify the bus token checks so they explicitely check
>     for DOMAIN_BUS_ANY instead of unspecified checks for zero.

Both of these were in my tree with other commit IDs (and both came in from you):

  7b9414cb2d37 irqdomain: Remove stray '-' in the domain name
  c0ece6449799 irqdomain: Clarify checks for bus_token

so you should just drop this branch.

              Linus

