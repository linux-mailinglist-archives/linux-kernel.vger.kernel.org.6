Return-Path: <linux-kernel+bounces-555425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F524A5B733
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C992A3AE57A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA91E9B20;
	Tue, 11 Mar 2025 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrVVXhSd"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FD1E25EB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663756; cv=none; b=bdOd/dAlkd2zrlnBAsO3E0K0bAauVD+HhDU58yGUBVi3pECShbLH54l6V8ELCX8S/g6fOXNZlSKlptVFAfBAKm1qWJ70BmyOfrdeQOxvjT+cP22cOPPZ+wbJd0fBGHMR2YKFgYNsHONni9B/ssprKC5uym+QiFUUeDIapwuqAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663756; c=relaxed/simple;
	bh=RjgTFTD35DzH7M58NBn5VloQC/c2jAg9mwHVti07ous=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLr5c+bEN2M8p8FwC2RQ9afWXOu45WxrOQilStbaBSJTKHBqiE1iA4CnDurSypVHvSS/JmIrovPCQUqJfP0Rqt5d/2IiM4IipA5i27YsE/Yp9mJhWG0rirrqoJKJQ6Er0SWOIFl/jzifwv+WFn9+4HRMAizuxiLXA9ARW0vbikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrVVXhSd; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e53c9035003so4523812276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741663753; x=1742268553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjgTFTD35DzH7M58NBn5VloQC/c2jAg9mwHVti07ous=;
        b=MrVVXhSdhCEPXJpyD+y7+302DYXnrol6/BPCaZBn03YN7uNB64dlZ5KZ99TdjbpRxE
         swMsSAwKCE3Ku02bdbVqgEzaD8kW8Y4Yk9DDV6M9vFdHc0IX/GkQ/ZTONLrpwPdlCEYN
         lco80VYLKxyEgy85Z2nGXROHKsUZS/CbIPlynJn4l/Nvd8y9QQyaySbQmFhDoy98xfrW
         bmw0BNZUjZ3900JtCt3TzpoWAZX5Vherh8zKxB3gtM2U/yKFWjJgijeaVpkVSKujhxcM
         4MCVsc/MklRyE4E8PTSQf86HqF0btvr6daZh307jZzzlMnwai4Rs3M0i582F84mReAki
         kolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741663753; x=1742268553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjgTFTD35DzH7M58NBn5VloQC/c2jAg9mwHVti07ous=;
        b=qBOnRujAMi97rKLBBQ7haFSzVjuj4JvExFes6m3yJIO6r5G8wy+ql0JozAIxRaLq4C
         qgGe1uQmUe10QZ9oYw+Vwo8+ATqfByDgYFhuUPv9qM33XlqsEAMpLFwcCNsK6SFFRfrK
         NpCLFZw48GdNkOAtLVJi0HPeoM72K/eytg6e3YViLZcYIlgu00CAxQu3n/TlLbKbJ1l3
         FJWUOLtSL9Vwmxg2huutZamSpfNEWhVlVlVJSEEF1GkuoeQSFqIAN0Fita7X4a4PjIf6
         f60NmDD7dIusnnG6YbWPKlI+j4tqVdzBhmMBcWWXyrKXftDXdWm8C86g+OBqU5VAQrNo
         1cOw==
X-Gm-Message-State: AOJu0YzJYPaCeZUh92gxaEpz8/oz2lzQzPokb/7uVY/gmtblAGJu+06L
	UmVA1pLGCrh5XT4kiSdQYaV8pI4NpndEmVPTJAQzqCdsPIR+rXumMg8OhFukisTtj47uZnvmi6A
	ffbiHx/hA4VbzZ3RWpiZz842wU8s=
X-Gm-Gg: ASbGncsS6JfUNUWl+OKTsIXYIP+WjuMhvn/RP7FlpgOyiUd4Hox5mRnWin6sXoSU3rg
	3PB9gx1JFpbZxbj/gKeHM5GzPg3HOUp1m0JO/5yAKaUCr0NcNGXAFtdhKmdt/5k7YbK1KOq4GSe
	3Cn7HUFOkREh1rTaNOnhEx0XNIOmpdCwnibDEhzrqQbaWI6xObUuwaoWyJf3sT
X-Google-Smtp-Source: AGHT+IGvxd6OskOE0VmmPPV4JBzwFrbR1QFfg3hKPUWbe9OBvfpgZ2fclALvQq474bmc0HMrNBxuCbkDrcB3DcO37Q0=
X-Received: by 2002:a05:6902:1ac5:b0:e60:a1fc:121d with SMTP id
 3f1490d57ef6-e635c0f9f21mr20526671276.8.1741663753591; Mon, 10 Mar 2025
 20:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
 <20250311003554.GN2023217@ZenIV>
In-Reply-To: <20250311003554.GN2023217@ZenIV>
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 11 Mar 2025 08:59:02 +0530
X-Gm-Features: AQ5f1JphwtS8Ml4iERGqyKDuFJzt9uPihcwdkAAkH_bTndEjlHeQi9PcW1WdpEI
Message-ID: <CAFf+5zgTgX6kfoaxJk_BtKOkFHGisxatayxMN4XcM_wRJw9Bnw@mail.gmail.com>
Subject: Re: Catching use-after-free easily in linux kernel.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 06:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 10, 2025 at 01:24:54PM +0530, Amit wrote:
> > Hi,
> >
> > We can catch use-after-free easily if we do the following:
> >
> > kfree(x);
> > (x) = NULL;
> >
> > Now, if someone uses 'x' again then the kernel will crash and we will know where
> > the use-after-free is happening and then we can fix it.
>
> That assumes that no pointer is ever stored in more than one place.
> Which is very clearly false.


I will do some experiments and then I will reply if I find something.

I will introduce a global macro and then change all kfree() to this
macro name using cscope probably.

Then I will compile the kernel and run the new kernel and see if some
crash is happening or not.

My computer is x86_64, so I will be able to test only this architecture.

----

