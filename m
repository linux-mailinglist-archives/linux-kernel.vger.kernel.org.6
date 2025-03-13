Return-Path: <linux-kernel+bounces-559196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3DA5F0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530D0189AC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754826659A;
	Thu, 13 Mar 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BM2GBNYK"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE063266587
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861506; cv=none; b=YsSYCXCDuSxK8B8eVnhr5C2SZP9AAgVNb3S96uLPfVMTDCDCMoQXlB7FWWyoN0iuXifZm0OR6J36AWlJmlERK14mPa4U/VteqsLMde0BrkBlYWgTbUfNsRJce/JKNqctlD2xqZMTqxbaYBcYHsjaU9KHUB98a7QByWgRUb+1IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861506; c=relaxed/simple;
	bh=8E6umR10j1rENZETug8Dvg2uUuaAmIVEZ7lWr0xEUcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxPAKuLjkmXXe1++y+YxB2lAicNXNuTpQ9aSphkwEFQretj/7UOkAJ/0b+ZBZiynf6OmHB4nztx6RcIrhuI591EVvVLT4W6MjZ0qn02JRMmtM9Mnee/dXbhd/MOyCDi/YGL97HUGHgVxxAFGnK9OQO3YVDns4Ek6ixN+/1EXDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BM2GBNYK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476977848c4so8116061cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741861501; x=1742466301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJhgDmPv4xBV5PkF1YNcGYxiZv3Gvw3+dAdLt1/aqVg=;
        b=BM2GBNYK01C01waNLwyT7DJ/iUp2nqNVVHfgWggSuRM/YOuCkZ2y/rTlNhUi0ePMaZ
         WChuCapG09NW93nCEdbx01p7w1FGxaakl0vIs1vRXywAFIQ1nnVafY0vCBS0W0uvD10E
         R2Bk1QuNQA7YIfvwujdlB4CdUnhKy9g4Kp6Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861501; x=1742466301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJhgDmPv4xBV5PkF1YNcGYxiZv3Gvw3+dAdLt1/aqVg=;
        b=fBlb1wK0NbUITyiWjyOzYJuG0mfpxxzs0yhtfzpvBgR9w0nxMQ4n1pV/Qqu9zh6URJ
         MZ6HnHoejoiavkRylFO14pYk9k7Z1CPIDCC5o6eBqOD3OLGA9ahlcAjda6PEg68tZSDZ
         KCz1JwOCE2nr/+szHtFXRcinS7a0tG5x2Hzt/x/3zM077ZHFJF34n6x50O7FxJFFbs7R
         pYDJ5VLsS3c6+RCpjgr18CilI1gTiPia5FJQdabZz039ZmCxdZH7cIAs8a9oR3nOg5DT
         vGxZfv1FH/KUXv5HV8ALKkH3qjyOL2xU8SOFMtPDevHgz9aB0XHFgj/dZ4TTjOL89z+6
         1ZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXz9YqxvBPkqOVOwU0vMGgAs9Ee54pPOZ1L0RrlgmsG5dANtN4FgwUzlLuD3I8981g6nFWzlpzA3YuRlp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0mPsD9cEu3H50O907l41JbgoKqzO2RlH5R694e8UxBNZfF9X
	eskmuE0Ut9XmOJHPxIuq45E0sr6y0w+wUhLWKDrILVYCFB3FibkL646bZdGY5bjJ0M2WaaawvO3
	ZKM62jAz86Qpw77doLj1L2VgFtNZK3X0gDUvLsw==
X-Gm-Gg: ASbGncuK6otX4ecmUnD0/vV5AK2jbTbseoXy6Ou2sU7xxxJqc1u3b46roVN2FGTV2mn
	TMJNMT+AxnltsWpJVQr9w0pbC+S+q7hw+LgeQPfI59WkgnH5ntmdI0Z/esnV4otNhbvItI7HAiF
	B424yB6sDzZ0lPTGga5icCEwIF2x+yk6vjqxNh
X-Google-Smtp-Source: AGHT+IHdTEwbvkDm0m+4tqN3e2+RcDe0QvKRnYufGZu9tB9rQzpkkt9gHNhJBwNlIq6VgZJwrE5aV3eVmfIOrbHnPQ4=
X-Received: by 2002:a05:622a:ca:b0:476:b858:1f2d with SMTP id
 d75a77b69052e-476b85825acmr39382321cf.42.1741861501656; Thu, 13 Mar 2025
 03:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com> <0bd342bf-df71-4026-8d26-2c990e99b40d@bsbernd.com>
In-Reply-To: <0bd342bf-df71-4026-8d26-2c990e99b40d@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Mar 2025 11:24:51 +0100
X-Gm-Features: AQ5f1JrpbbkOvwOTG9jY5aBl6NEjKVs91x3eB4o9jjaEB8N7vTieFquCBJjS7Nc
Message-ID: <CAJfpegtG2PS0_moONf_ZmLncv1EH7HtC_8ZYxwkEiGZy4cYZaA@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 21:11, Bernd Schubert <bernd@bsbernd.com> wrote:

> Can't that be done in fuse-server? Maybe we should improve
> notifications to allow a batch of invalidations?
>
> I'm a bit thinking about
> https://github.com/libfuse/libfuse/issues/1131
>
> I.e. userspace got out of FDs and my guess is it happens
> because of dentry/inode cache in the kernel. Here userspace
> could basically need to create its own LRU and then send
> invalidations. It also could be done in kernel,
> but kernel does not know amount of max open userspace FDs.
> We could add it into init-reply, but wouldn't be better
> to keep what we can in userspace?

Two different things:

1) trimming the cache: this is what you are taking about above.  I
don't think it's possible to move the LRU to userspace since it
doesn't see cache accesses and also does not have information about
some references (e.g. cwd). This can be solved by adding a
notification (FUSE_NOTIFY_TRIM) that tell the kernel to evict  N
*unused* dentries (valid or invalid).

2) cleaning up of invalid dentries.  Dentries can become invalid by
explicit invalidation or by expiring the timeout.  The latter is a bit
of a challenge to clean up, as we don't want to start a timer for each
dentry.   This is what I was suggesting instead of an explicit
shrink_dcache_sb().

Thanks,
Miklos

