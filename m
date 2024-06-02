Return-Path: <linux-kernel+bounces-198429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC28D7822
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2357B2267E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B07770F1;
	Sun,  2 Jun 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wl62wz2m"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A191F60A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360730; cv=none; b=t40Vg+fpuMLTd5vwizXD3EzUEPl9vF319yVdxk7DMu0tjGRSQUZRIPwla5CA8rU7FlA2nzQabm7hxQuZiHlG37WoxXEDY2J7uh6ZBujM7jNAXKi3RStlUUEd0bZXe/zadEpd2Sf8MEM3CpR3UXALfcujOIEkCEauc7Ot7J4fGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360730; c=relaxed/simple;
	bh=rhAipHo0iReWCR8r3p7k6LrcHyWRDnTkTsB18JeCC+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAiu4rpMWtpvpRy0heFU87HEpPJjjpGmuzvYNqs835pNtLuCHb7Vk7cOJgt+0ipWw9HE7DFkDS2nv4WpUMtXsEeHjtOvBmVEUoEKiu833Xku6T+49NACQz8xI04A1Frw/gNP5ZtQOQ+5Yu4+0nhV9crUyVhCcCc8odExos0n9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wl62wz2m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b8254338dso4215645e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360727; x=1717965527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ClzVWVll+3XBqVlfuVerBNtJg/SS8Ptde+96wwxtGM=;
        b=Wl62wz2mW63ucSxaoprDw/j1c59wlJr9V8lacwtx6rDW35iUAdNbci/tnAHl1AjtJ5
         JkT5X5Kf63OblWSl5gf1EMIYUV8aJ1qT5E0gY/HzhBVdRwX23aKKY8lFQmnBOro0oNXz
         Bt/TSqVu5ZQ4M71T89H+gsRAnNY3LciDV9LDXHHwY7BaTGjF0mdLoCN1uAkuql1oMTSl
         Q3/LeYqVZbaEIwyx8zP3GwncY5qEt68/4Jigl001cV747+hxRaco68MKUIiCCKjNUh8s
         7W0HIc6Ptcmzm2iZCEC7F3S1BdZ+opLogvbDjlEro3YMswy8KuDb4XBRcZuh2Ilww5iL
         7pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360727; x=1717965527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ClzVWVll+3XBqVlfuVerBNtJg/SS8Ptde+96wwxtGM=;
        b=oNR9gwHkmVh1SO4evSqj9aE/ccFHmre5TPdbwnADlv/tSf3wCQ0M4EsQh5IQi4dzBR
         5rLwu4uuaJIygKNz2unh5edX99XJX6xxq8+VJQ9hn4aVEa+u+yvWo0mQ9/qGevvJa/QT
         jfTMeMr13j6jnBgA9AwlnqU/vIi6i6J30EDAIvB/bCS2kGAIoh844cSocY1ivUgRnqlm
         GN4PxHERKLOfPLG0v1kizQcm7K6DVjMD6M/0hne/9NZ9oScIuj3ygOFEGITcKh6Lpv6q
         qxCcxHlnIIIHo+yAQPrBt9/nXjTkMfdML+Jkyh3OdYKi+yTaEGY1M0R8z15E0w662G1R
         3qGw==
X-Forwarded-Encrypted: i=1; AJvYcCWlwz0GFeLXeQt3WRwRyYUmwaufDY5CSycayNVzMUITiuc7jwMDo8tq6z0g/YRU/+r/wjLYb7jJIIGSmcxnYkajmvA1rlt9gY00bUlY
X-Gm-Message-State: AOJu0YzL3kQCejnY2E4QRu9sVQrOGtgldWZzcDySl7NLA6O7Dz06vKNj
	wPmPmM3oP8BTTo58/nseqXvAYUWqpbzYAWLV5fmFRB0MUVUejpKtlfItItwDRVH7VhlGX8tvn4Q
	Y1qa2
X-Google-Smtp-Source: AGHT+IF9svab27OxqoEIAvhxVqr4Bo2cM38fwBVighMBD1wNcLVHdr+TAK0n2DWmqueuCEG+M4mXwg==
X-Received: by 2002:ac2:5dc3:0:b0:51a:f689:b4df with SMTP id 2adb3069b0e04-52b896bde2emr5507790e87.44.1717360726392;
        Sun, 02 Jun 2024 13:38:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9acb9ac7sm91563e87.281.2024.06.02.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:38:45 -0700 (PDT)
Date: Sun, 2 Jun 2024 22:38:42 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH v7 3/4] perf annotate: LLVM-based disassembler
Message-ID: <ZlzYUjBJzlERP37P@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <20240526182212.544525-3-sesse@google.com>
 <CAM9d7cgyBGPc-HCC9nk_xNiVi3LZGM1-dE5OR4FxRvNWoFZFDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgyBGPc-HCC9nk_xNiVi3LZGM1-dE5OR4FxRvNWoFZFDA@mail.gmail.com>

On Tue, May 28, 2024 at 09:06:24PM -0700, Namhyung Kim wrote:
>> +       struct symbol_lookup_storage *storage =
>> +               (struct symbol_lookup_storage *)disinfo;
> You don't need this in C. :)  Also we usually put a blank line
> after declaration (at least, at the beginning).

Done.

> We put the arguments at the same line and align them.
> Please do the same in other places.

Done, I believe.

>> +       LLVMDisasmDispose(disasm);
>> +       free(buf);
>> +       free(line_storage);
>> +       return 0;
> Often we just set a different return value here and share the
> error handling logic at the end.

Done.

/* Steinar */

