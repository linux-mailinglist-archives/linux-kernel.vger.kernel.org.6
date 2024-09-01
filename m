Return-Path: <linux-kernel+bounces-310070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53D967467
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FB41F21F52
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7133D8;
	Sun,  1 Sep 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ACIgYOOK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E51DA23
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725161151; cv=none; b=euKHfT9gKlOKc7Pp7+r9XPAP+Xn5aBRa9c4Qe4bnkiqyB9NmfbQke8sV9V9jRIGn65K7CKefXVpPznca7ytlgarmkHHnh4+2BIGmMMiWJt8tGGEw/W2hUUWS9jic1NBBQ5ZaNZ0uNA9DxL5zPsNNjOogWzI/7ZMcSk43ttdXWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725161151; c=relaxed/simple;
	bh=tcx579kBQXIkUt0k10DF9rAN3Ao81wX5xr2qhmf8S40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNgYKVIWZ3mqKBi5hpu+6NcA8wFfl7lWa3EGJUmVsGs63T9rOKYQNlw4UCyBZ5MrLQPtZ/Iw8fFCZ/82awfLMmGuLFOAoU1mgxq9uAlJYVEggdea568qOZH4qL5vqbbAiq3qopnNZyoDithNjBS9uNAAM15MmT02Kt4PDCTEvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ACIgYOOK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso2800819a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 20:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725161147; x=1725765947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HC1nsfFJXyTdVWcxISQi1WPBRNOn9dIaZqfB6NKeE50=;
        b=ACIgYOOKxHcEjiUQ+JneiTl/a8T8++SJHdwc5uHKsS+40zSOpl5dyeQudpIif14SO0
         0vXUMtEFOWKGMpA7yQ5T7qO4TrsipEx2VLGP49tV/BNrwDe108NfrlkHf0qsqTrPNfAU
         5Cb38C0Qyxt1reRCkoOR/meIzkfEKQnm592Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725161147; x=1725765947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HC1nsfFJXyTdVWcxISQi1WPBRNOn9dIaZqfB6NKeE50=;
        b=LNYvW5X3R3sZKO2m6+sisVCQkci5VOMGn+7OGOh5/MweXdkGyRpk+0vNypuYZtgD1Y
         bnAkM0MReuZP9qUXP1/Tup1LvdnYDohdkQw4BIyi9ZIzSBSBXxbs7atGtS89p6U4uTkS
         SplD02UYjI50yLYJfqHSCL6DN7PNQuW5ppM3tVFPjxhV2evhnx+Eiqt3T+HsfW8zuJG0
         a64RyniLZF7fjAJSfk2tFD8jm1l0O5/VyRpTri3os8dPDcn+vx8BwAGib4tKXNUGtyao
         iYhf9XfZ5s1Pv8eYLz7wRZlp5PH1bMGV1dEy+nniDySwObnO9AMwxP2vfOxo31QiLUrc
         ricQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9lQuWmcUcEqJu9U+b98A9SRGpcG+rTFE35jepaLxUdgNt5eG3ihteTlr9iJ3yS6qvErdh0f/tDSpurQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynO84SRn+t5RIEoibPrmYC2S4m5bxtxvWZcPiphFfK3IcTUii7
	k2iZvVTsiVTfbOOTUv/nMd5fducmdpB2bY88QU5/mfa8L5ITswRrSc4Tnoqzt53tdYCSEao4fHC
	1z3atug==
X-Google-Smtp-Source: AGHT+IGThdiefWQcideyuNXTQ8kVKl3F+kxD4GPZwJMhd+aRayQVTOmqMRgbe3QotU2yW5lxHH1AyA==
X-Received: by 2002:a17:907:7da6:b0:a86:6cb1:4d49 with SMTP id a640c23a62f3a-a897f789260mr758405266b.13.1725161147034;
        Sat, 31 Aug 2024 20:25:47 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968a3sm392540366b.142.2024.08.31.20.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 20:25:46 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c210e23573so3152868a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 20:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUDYIBwAvyyiETT2R3+mSp0nfvmKNs3AWkl5zi3N73XWykmK3F1HW2JBUF1hzzXIS99ip4JpVYiZ/HMr8=@vger.kernel.org
X-Received: by 2002:a05:6402:42c7:b0:5be:e9f8:9bbf with SMTP id
 4fb4d7f45d1cf-5c21ed406dbmr7079645a12.9.1725161146176; Sat, 31 Aug 2024
 20:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com> <5q6h447wzxlskkvgygm3xb2tasbbgmmtxsxd6m4jtygpwsf47b@hxdqfn3nxqzo>
In-Reply-To: <5q6h447wzxlskkvgygm3xb2tasbbgmmtxsxd6m4jtygpwsf47b@hxdqfn3nxqzo>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Sep 2024 15:25:22 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjPQWyYf0Jg6KG2gUYz4HEPq5BT0N=Vx6ECOx41TGvZiA@mail.gmail.com>
Message-ID: <CAHk-=wjPQWyYf0Jg6KG2gUYz4HEPq5BT0N=Vx6ECOx41TGvZiA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 15:19, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> odd, everything looks quiet on it, but it was acting funny earlier today
>
> I do have a github mirror though:
> https://github.com/koverstreet/bcachefs/ tags/bcachefs-2024-08-21

That works. Thanks,

                  Linus

