Return-Path: <linux-kernel+bounces-335183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FC97E252
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3925A1F211D0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AE29406;
	Sun, 22 Sep 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aBZ7da0Y"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4928366
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019592; cv=none; b=ib6lJCU85+cOGuzjVrtgk83MrxTJn23ZVJZ1/yAwfpNufZ7YoRPXeVOqorBQajiszswtOSM5q9JuU10xEnKFNCYEe5/9S1Sp/kThn+Tg/74DjPEO/vb2Uo2gqoIBdn4ETykCBjn9DsxfK3XBql8NmOiROPmpK3V9n+2tzTl24dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019592; c=relaxed/simple;
	bh=PUgL8/X5kk0A6C8lhHqaF3yeeShTkPQEj3XfKgJqe94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkhZp1bNTxSjUuKXd8hMp4NGXfGixEKzqMpHUj5GqqY8TkiP+YziWHeqnKd+VkXa6q1hXt8QGwESBSyGYbRANRJy2EuNFlU1aAwg54E98PQvbjlL6JPuW97hV9VB+qq1K9OB5MuJc9s9gkKkD/LL4DNwZPsgCBJkt3vbFmJvtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aBZ7da0Y; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso4687919a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727019589; x=1727624389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFxgZTFjgb2JZJAextayyq2RXVTLpxRhrGXsrPnvanQ=;
        b=aBZ7da0Ygm5sP7P/K4lwV4smWIeGWIrhlhuLmkUCKl2VAH6T2QRf9TR2aYfMrwkCI6
         mTHTUqvRRoXx3JEfYf4OWmUmwr7zdL2tC38cAjHla6e87zGvsgAB5NMv0hjlTZK0CVEO
         JO0/72WFQ4splWuNvfqR7A4GPFFh349K9VUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019589; x=1727624389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFxgZTFjgb2JZJAextayyq2RXVTLpxRhrGXsrPnvanQ=;
        b=PXssaLIuMaqU2aZAAxSwHTceqEZ6hNZ/s+Ju+xzBXXA4Mwy4KeU/56cVNi+gdaJx7k
         KXNIEV4o+UfnxOF0KbpmxoyNHtRlOCdqjaoGNMQn00AytSa14XFp9VK72iY8cmRwsRDt
         CglGbCdYxaOBLmmZXtVqSbnUGGJuiDWgMFjM/IuNajIj2gUenyTm21huQYwS3C9ck+mJ
         gDlL5WkGeQY9eBR1etSHuUS3NH8PAP+n9BO9c8JB+jdE35kglea6jABRusJLDT6/z6Jz
         pcd6rNzlgX9GM3flQAid2+9OROYiIsIWo+weuf0vUg3Pdwh2vSf28KiUxxKSnRzU1YmH
         cbPA==
X-Forwarded-Encrypted: i=1; AJvYcCWlCqHoSMM9TM7YzOihq5UJQSS6Nv/dv1jfdfteLjNIoSyl2Z4civc0Gr1drOxDgzxHup2jWVVybHJ2qwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUR2sBo8ko02CGWOCS0gS68rg+s1lqihbhwFa6UXglqSr6vikc
	EhQ/Bgavxf5dkZiW/xLFy1Z5hy4IC0XStX6dYsFutEf9INOxX/BmXseugKc0n9uzb/6LplrbJey
	vO+A=
X-Google-Smtp-Source: AGHT+IERMWmfuaKLvt/cqlO5wBhjwIt739a5KZ4GbCl9lDVh0CXw6MmoBrfAZ4SVz1MOwDS9S2zCPg==
X-Received: by 2002:a05:6402:51d1:b0:5c3:cb1d:8176 with SMTP id 4fb4d7f45d1cf-5c464a7ed74mr5877467a12.30.1727019588670;
        Sun, 22 Sep 2024 08:39:48 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc89313sm9267494a12.93.2024.09.22.08.39.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 08:39:47 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d24f98215so467906666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:39:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWikFugh3sf80xTAITF8QZWQ1K5LMgzX6DauNS+UPB67GtWQO98i/D2BkXBQx7vyhsciphe/tgdEFNm77I=@vger.kernel.org
X-Received: by 2002:a17:907:e253:b0:a8d:3085:a7b1 with SMTP id
 a640c23a62f3a-a90d50124d9mr838803866b.38.1727019585320; Sun, 22 Sep 2024
 08:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905021916.15938-1-jwyatt@redhat.com> <20240905021916.15938-3-jwyatt@redhat.com>
 <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
In-Reply-To: <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 08:39:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Message-ID: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for libcpupower
To: Guenter Roeck <linux@roeck-us.net>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "John B. Wyatt IV" <sageofredondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
> >
> >  .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>
> This file is deleted when running "make mrproper".

Yes, please don't create files called '*.i", "*.s" or "*.o".  We
assume they are generated files (the result of the preprocessor, the
compiler, and the assembler respectively).

And yeah, obviously "*.i" and "*.s" and not _usually_ seen, because
they are only steps on the way to "*.o", so maybe they aren't _quite_
as obvious as some "*.o" file would be, but they are very much
standard naming, and we have build rules for them (ie "make
kernel/exit.i" will create the pre-processed result of exit.c).

                    Linus

