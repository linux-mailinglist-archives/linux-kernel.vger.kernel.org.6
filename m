Return-Path: <linux-kernel+bounces-281382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98194D641
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E591C2145B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3C5154C14;
	Fri,  9 Aug 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OgBRrutC"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185F14E2E6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227885; cv=none; b=DCcg+il81kOUwdCLT5Z/O6bPiHZDgXn/TLt2U/874jP6rlYanBxIWH8zpCQJBRmtI8AHNINMzr7LLvhSDQIpm9PkWEe8szGpjlukPY5ursDmQfNny1vH2HuNrNXS+Hydy7BRF3RsHGu07HUkpmw7Zn8tNLWcyspIYgd7Gp6Uz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227885; c=relaxed/simple;
	bh=Mcd0fv1i0w63D4HU5f6u0GztrmIlHT4U5W42HrH+BSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC+dpVUBZB9/l5zc81qGPK6kBBhJs7YEuVrmMTivRfyEl8gC5QY4KBMjHRyMMmQgsb2Syo/8hDo6XuIDLRg9e4GLar0gajMtyI/Wxj4846xT4MEghUbt0I5kFMgbyYKgll9lR8ni5AbsWQV6U4RW8XXUaThvP4YW8VthvTAfluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OgBRrutC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f149845fbaso25544531fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723227881; x=1723832681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQpIDwEYwFYAr5Lj3TosIy8YXjTZUix0dhQEGaAyfVQ=;
        b=OgBRrutCYS9L8ccGPMdblXY8/9cikwbb18ie4+w9qLJBjPK1Fmy25Rw2cyawhfww7x
         H7PNgIbkRWpqhg+8rcbAw4rwXJXk6otwqC/XqjXwlKjQszxXoHn+grgEnS1hCSc998Wk
         vO75gXJcqACjtl+9ICK6/0fkb+I92eQBhudKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227881; x=1723832681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQpIDwEYwFYAr5Lj3TosIy8YXjTZUix0dhQEGaAyfVQ=;
        b=XYS8ldKFJv0xJhQUe0/Yvyy427Q3qzwDk/5x8m35CcQugOBucFKshE+TBK7OLJe0Hb
         JkcyGcQSPqckEdzegDlyBpnrC6PkJCFaF7PnctBubE8md7/SiTGVomKJJlANldO+BXCm
         7iO9qlt8d814W1APS08DoXbm728730MvjOaudl0Pgszl46MEi0RbVjQI/sHUxr8aYboJ
         T7/THRNQNUwEAU1r9z4viHOXsOsyQpVurXBYaFfV+FcM2KWPIsRuvZkdLJCM4bquSPYm
         08E36gndTIjP6sA5sqBi2X8QTc1lyk7eYHtVgUOCl90Kwj/Pf6gQxQBoqMtmekgAuSxD
         dY+w==
X-Gm-Message-State: AOJu0YwZ/AnzYha/RfcLV189lIjBtrOdkoWWnvFEJqdejQVOon8yBGpU
	TgU076Ir/PiLEAQsOkfSbF7wodSAG+Xv0MOG3ubmHJltaZUOsAlltPWJdqE7n2YVpZA6oMxa7fb
	e3MKkwQ==
X-Google-Smtp-Source: AGHT+IFQ7TcdARY9isKckGREo62f8/vIaC60zk0sH8QZQer4QXwsPZTcaIZiGyMJjYMT26HxvSaASg==
X-Received: by 2002:a05:6512:138d:b0:52f:cffd:39f9 with SMTP id 2adb3069b0e04-530ee984473mr1800009e87.24.1723227880844;
        Fri, 09 Aug 2024 11:24:40 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d34a69sm1707741a12.70.2024.08.09.11.24.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:24:40 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a8caef11fso275021666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:24:40 -0700 (PDT)
X-Received: by 2002:a17:906:bc06:b0:a6f:dc17:500a with SMTP id
 a640c23a62f3a-a80aa594533mr202857866b.23.1723227879885; Fri, 09 Aug 2024
 11:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
In-Reply-To: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Aug 2024 11:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9gEpGGwkeH+DWr11eiVNY=irUkCogkWQDM_h5-znuUA@mail.gmail.com>
Message-ID: <CAHk-=wh9gEpGGwkeH+DWr11eiVNY=irUkCogkWQDM_h5-znuUA@mail.gmail.com>
Subject: Re: [GIT PULL] cpumask fix for 6.11-rc
To: Yury Norov <yury.norov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com, salil.mehta@huawei.com, 
	shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 11:11, Yury Norov <yury.norov@gmail.com> wrote:
>
> Please pull the fix for set_cpu_enabled().

Ugh, what a stupid merge error of mine that was.

I've pulled it, but would you please make sure you do proper pull
requests with diffstat and shortlog in the future?

           Linus

