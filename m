Return-Path: <linux-kernel+bounces-562310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A84A6228B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA51882C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0333FD;
	Sat, 15 Mar 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bt31D2hP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245836D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997360; cv=none; b=nxxg4gO5/uvs/E7N/FQurGd2a0hn1Ck42roLH3z7Qs7Cum9EtT7hbdM5ZnnHMT59BdpQIOG8RGfsLlo4JQbsbn+7g9MwAd27kWu4xVRWTGijTxhO1ZKmlw6KF1AoaCH/GdscHyQ9ay5WyqFwc3jspKaeZnvyXKPprLAqPZu/iYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997360; c=relaxed/simple;
	bh=Tk7Mc/L0Uru7Lxwtwe8SxQqfPIRFT7uUArUqihjD+sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teWH5NeRz/5VP3Mu/qR2ig5gSlQrlZ0x1wgYZX4SzNVPDIVVsVJB8QYjpK5E2PYeGVUIrJJ+jyIMzPhBelgG9FkRcMQ30cofT/knkTy9CHdpNWRSxK8OVrjt2oR0u1SD95QZ1P74FCL6nHGAZYrGctaNFTdqHTDDCrrDoThvHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bt31D2hP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac27cb35309so417246766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741997354; x=1742602154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9b8jZBSOtn8NLuJNrlHfcMekSs0Id4ZVj4HYXH1a0c=;
        b=Bt31D2hPW4Mu0fwa1fKNyd3KkbpNRqU/ih+W5yen3fL5sLFqr/lT4M8eo9NIVh9DVf
         p4P/AgqcuDnQdHhBgQYCyVkS/bBDSq0idN00NsVrSckrgJh7hs734YjDf7M9QP3iEy8I
         kzCozFP6oSDYsPmFVLOySwacWmFtsCF219VfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741997354; x=1742602154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9b8jZBSOtn8NLuJNrlHfcMekSs0Id4ZVj4HYXH1a0c=;
        b=QoQExYwLXUvrIzTyPx/n/PDcInIUBXoI4Ajn+Uvppcg2GTUnZYYLoY3c3WgvxWkGu3
         Xf5cyHrYuvtDuwVSm3rooEdfdiYqi3y1F1arqcUILEMlx47ArbxWSdDn3NfpAL4ufw1S
         UXTIvUZh/cDW4LySRNkHRG+UJmoaD/TGEnqgL4kuAyAgJZ0qPbuJT0H4zoENmgc57NTE
         G6X2GP2jd6eKIf6vdF2OS5F8umYGUqBIAMlk4lZz01hh3j4RIUEf0Tgi3OcnBMSE32gc
         9dB2ApR3l55wYDCsGlGQ8IMjEjlIwZ7NWkgdDDBt9Jy20oyUbJERgbhd61En48ev3snz
         c+mA==
X-Forwarded-Encrypted: i=1; AJvYcCVp6e2Qnb5Ogx2SNXZ+uxeeDx9oI652kApbSjK8xv29B+rpeZHRTv+wfGg8gr8xb/LSEKJqzNArtngL7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKOGssvU4Ys5BnqYhq1kNaM5seVEXv6coBaWVRwnduq8ux6p5
	L5UoC2KOuURNiRPgvO3uwCjRIddAlgN7zkGWrPEFi1vEd3aSNyiTy+pJC10mwiNG19ldBNkLZMz
	w/ck=
X-Gm-Gg: ASbGncuV2aEZAqF+UoDmbxdbaAfUrxLPB3XJR0DmFTVR59m1fooWvzUy6ARQaT1ue+t
	DknEmr/YbKts+oDozWWLx/Sq2moEA0OLNQGlCRupO7PdU4f7JQ4LP7eKrZlxgQBCeX5XqpZVRFk
	pjSJMTaGxSsgTxan04d1Pg1rBxS27oiLL/jbGXnPyDw/oY/gsj3Jzk1Dhr020gQUCTwVnBpBojS
	rbqWQQjSeXY6vNZOVRl6ZawhmXHz5Q7xoEoVwhpFI+lc2gLTkMnrvZ7SvhWoyNi04Jsac51Xqj+
	vHjRzL7jyIXSIJiREhFCkTpcOxb9p2UmebTn6BbeEconZiq7OA4IHpH5sNVe5qy8MYrWswx/N7e
	65FM5dKdI0tXeWa/M/DA=
X-Google-Smtp-Source: AGHT+IG7UiSLPIP7NM8H43+l1aaD4tWb25PjC0eBu/k3RVumF/dQTLmb57K7mQQfCsMNqbWbF/eM0Q==
X-Received: by 2002:a17:907:7f04:b0:abf:7a26:c47b with SMTP id a640c23a62f3a-ac330373b57mr437585766b.39.1741997353836;
        Fri, 14 Mar 2025 17:09:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cdec8sm291777666b.112.2025.03.14.17.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 17:09:12 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3849615a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/LSHfcGeP6lsOVJPuT1/IsBI8D19W1U5/Mo2Mp6R2VLexPrCBXmedsHXaIbjY75CC8Ybf3SojuZD4110=@vger.kernel.org
X-Received: by 2002:a05:6402:5108:b0:5e5:e836:71f3 with SMTP id
 4fb4d7f45d1cf-5e8a051bae9mr4316872a12.29.1741997352300; Fri, 14 Mar 2025
 17:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r6wusnyqqcmnamampwguyscjpvgwrnwhipsglryaltnofmmkf3@7b4fixf5q2qg>
In-Reply-To: <r6wusnyqqcmnamampwguyscjpvgwrnwhipsglryaltnofmmkf3@7b4fixf5q2qg>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Mar 2025 14:08:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=whyp8+TivigcJb_UxARH_QBACKgF9_38G1r0jq9c07Dsw@mail.gmail.com>
X-Gm-Features: AQ5f1JqaOeDi8cKfB_KrAPZAzmHOiAwu-CnE9WD7xJCYkUzwcxZCzABbEd2IyeM
Message-ID: <CAHk-=whyp8+TivigcJb_UxARH_QBACKgF9_38G1r0jq9c07Dsw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs hotfixes for 6.14-rc7 v2...
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 14:03, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> You'll be wanting this one too...

Bah. I had already pulled the first version earlier.

I'll do another pull.

              Linus

