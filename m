Return-Path: <linux-kernel+bounces-170517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCA48BD862
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5CE2841A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E3622;
	Tue,  7 May 2024 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2T7twXE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAD64F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040321; cv=none; b=g+tak3JPoOOX2wd88/t06QiqRMR/F3eFdGCx2W1iQ9tpiCMbwAgR3raXAWjlHUELHT21QvnKwTzGSDTYmIG8TdvgOzhC5JEM8YdvZ/pNZKVQigbRvHKAVr/aKlwc6rLbnOLsfg2gopj0G/L9DHj+zrWcUmtKppzh8zoXl9R8aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040321; c=relaxed/simple;
	bh=HPz//ch8ZRi2x8WCzJmSVsNjI/8HfUnEKKxsvoVrGaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTAexwoBtyNLDudVUwY1SCmJwzJEbV47mHYI7b0kLO4g06hvAnpP3taCyWsKcKQw/n0SFOS9c7f/eauYU5MtcA5fyh3EvMaF52+p+Jwj/GBjdHS69gCQFf743oMOkVsst3lItfhmZYnBW7YVDZz3aQVzDKiDA0qWen9mynMI2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B2T7twXE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e65a1370b7so23074655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715040319; x=1715645119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlvDANCVrZHWMQYFIBtkDUG6BaCteNwh6wwcOjijmC0=;
        b=B2T7twXEB5RJ1Ok+IYaKCubmp18Thhih0wzfdCpwPxjODkuaXcVAxSaH2g7Py6nBAi
         qzbiJaXFIvcWWty+WikiVp5VqH00+1mUwvimQblg7qbUwra2VgjYBVB5JcY5znazjo/z
         znF8oJK0skjAL93x3E9ErRk/ByXLj3uEs2hqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715040319; x=1715645119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlvDANCVrZHWMQYFIBtkDUG6BaCteNwh6wwcOjijmC0=;
        b=phItyAVl/7dKw69M/Z4+ODh/q3mzOxzXdT6kSVvtOg1Qrcsmqg9HPzXtGVAnP9wUbO
         QoDe1Rtu7HQXlO/vJBhUWS4Uw1b6kaXNSyQQPB1IjTIOM3CuZlhQ08KIaigwbAJ5Dr05
         w2JcxkIAzZTwFZ8haBU2fb7SS/wbLARQclSQmB8GL0tKpPwweDFdBq4dHM8RKwkdaue+
         k2i8mk8Vrd4xMiSqpKxXPz893gBpPFjMNqlf2sxOZpmSNW8TEXyyxGklrvSTzDm7HlIr
         joYXwKrA7iEfs3yQurFbhgmJ0I9KFcxbZALJvXw1ZDg3V9Xb9j6R9T6y5/aVNjEyEA26
         8HDg==
X-Forwarded-Encrypted: i=1; AJvYcCULU2VbIzrhapvd+egHYiuwexH9GsKhbIMqzol+Jz8u4jFkCJB6QWQiYyWL6orP9onV+3MeIzOt5PAooGCgTfMinCc4PvxBppYQ+Ijx
X-Gm-Message-State: AOJu0YwJAhG6W4qWlxSpijAmh2nRJNrq0PDgGOXd5qM7Dw0G6U9ZNGmk
	Ibc5nVd6qIe5jB8SMFhUayipe9BAmdflH2yUUCT9PE547jiiGnlW1Bo+dMydHQ==
X-Google-Smtp-Source: AGHT+IFhCMIL115zdj8pY5gtzUEO5BqoE/SHP70FTQHqPl7M/NDkraWKJXcYOem7iaZCavnsw+unMA==
X-Received: by 2002:a17:902:eb86:b0:1e4:a667:5528 with SMTP id q6-20020a170902eb8600b001e4a6675528mr16349817plg.3.1715040319219;
        Mon, 06 May 2024 17:05:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001eb17af8493sm8832219plb.184.2024.05.06.17.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 17:05:18 -0700 (PDT)
Date: Mon, 6 May 2024 17:05:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Fangrui Song <maskray@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, kernel@collabora.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
Message-ID: <202405061704.DD3AF674@keescook>
References: <20240416152831.3199999-1-usama.anjum@collabora.com>
 <202404161027.63F4D4FDEB@keescook>
 <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>

On Mon, May 06, 2024 at 04:30:27PM -0700, Fangrui Song wrote:
> On Tue, Apr 16, 2024 at 10:28 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> > > The -static overrides the -pie and binaries aren't position independent
> > > anymore. Use -static-pie instead which would produce a static and
> > > position independent binary. This has been caught by clang's warnings:
> > >
> > >   clang: warning: argument unused during compilation: '-pie'
> > >   [-Wunused-command-line-argument]
> > >
> > > Tested with both gcc and clang after this change.
> > >
> > > Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >
> > Thanks for this!
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > --
> > Kees Cook
> 
> GCC versions before 8.1 do not support -static-pie,
> while https://www.kernel.org/doc/html/next/process/changes.html says
> the minimal version is GCC 5.1.
> Is this a problem?
> 
> If not, and CFLAGS is guaranteed to include -fpie/-fpic/-fPIE/-fPIC
> (PIC), using -static-pie looks good to me.

Should we use this alternative, which may be more portable?
https://lore.kernel.org/all/20240504022301.35250-1-jhubbard@nvidia.com/

-Kees

-- 
Kees Cook

