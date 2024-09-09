Return-Path: <linux-kernel+bounces-322103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71897240A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1B21F247E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F6318B474;
	Mon,  9 Sep 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tvisioninsights.com header.i=@tvisioninsights.com header.b="UGl0DmRF"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58718A94C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915482; cv=none; b=pPX1yR7YWo7FuQ2hnYjiYVhDxZY8AADxDoiPZ+l37jae94F/K1kpA3magYbgOdrXZhpsm2IvhMxUtjZbg+I9RbNPuP5fXnBUfZmLBs3SRvI8W/55I3vT0wduV/scJjS+iV6VW+9wsinCgz2rXMPbUhLF1akNI+B9NogMUbbaJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915482; c=relaxed/simple;
	bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JlY8KsxMwFNUE5ZK6gofvmHlmjL7fMAuzFRv3SjtE3EBxzunRO2A2YUtFi98+kRTzJs/+FZtc0MqzalCFjNBhyKrrIQjCE/pEakWqrgjkJUV4BprnOF+LkqgIqXkVsWBBaszZjtLiXwAW0P6g4X+bAuxlWwZaBqiyGhBusHYysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvisioninsights.com; spf=pass smtp.mailfrom=tvisioninsights.com; dkim=pass (2048-bit key) header.d=tvisioninsights.com header.i=@tvisioninsights.com header.b=UGl0DmRF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvisioninsights.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tvisioninsights.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c49c9018ebso43037217b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tvisioninsights.com; s=google; t=1725915479; x=1726520279; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
        b=UGl0DmRFxCNwB1JVwsFN/vmEU6zhBo/D4G/0+E4ZGl1IIHUpWT7w7+rVm42q1VUqm2
         DJUL36J7VYF/ee2DmrU8dm3ResKUo3NqsXifEONj7P8v+Lpn2UAnndT+PYRLyfBM/xAV
         xJUaC4+4ISMnDjVS5e+i1XbpuXO897jyChLC/pHZ8BUc76qdr+R/Ij719AqNSDRzIBlu
         VBOmZIzIyrN0C6E4vwEYupTJ7cRl7OOMNO5jB06/QrQMCClFf6fnTfkcoISudfMyq8hk
         ZfkU1ibZubboxkHaBoZYs0ImJ31it5wzYG14P2yp4qJJKEcjHuoixWJcp8v/3IOtCCMD
         bQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915479; x=1726520279;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
        b=lSuHWMlr7LNfIW2gyY3cgmXrpxwyyCMEwUalHCpOcftmoI91PntsqbaBCJ+Fk6FnBC
         uqMppR0nl3G6lR82MHolzZx/cfqSaNXzzgXMTYGb9Y/Y6xyyJo7HTc8NlAzE7ISTZVYq
         cqH1WUeMv3T2PT2i8VdrF/axy4v5SNCYqP5XiASydR/0w4r/X726Rpofn0bbeBwurU6y
         aNqb8ckiaqMvHqv8WFZgqYryuVJoxOfZlTPlhOpwto/W7CSFDEFwy1Me1/mhDKuebi7B
         7QUjQu02RaqwojGYdMnDSp4vVZnUkgUwgDoabqFXosSCddSrVxw18aGiZB0ZMtIeBaq3
         wLCA==
X-Gm-Message-State: AOJu0Ywr+lTmGc2wCECu2LSOEs6pom0kaU98juyboPXRKAo6E0aIzM4S
	z68EkfeS+loZ+Auy1rEi2ivxtdtOh+P8I/z6TOUVbhKWDsW8Rex+qp9xcLcM8/zR8P9CCiitnLy
	ATN6npXbWq/u9yMPvlnPQYmvY94qmYmpRroDXC0S3cBx8lFuEO5c=
X-Google-Smtp-Source: AGHT+IF1orA8emKndjOJ/2i/tad6xxCgsRxmQyBlQGvdH9F9sv7UvwrvEA/tsy5zVBWAnjAOG13yOWajqFxSY0gauFU=
X-Received: by 2002:a05:690c:6a88:b0:64a:4161:4f94 with SMTP id
 00721157ae682-6db44dfe5damr115813387b3.20.1725915479053; Mon, 09 Sep 2024
 13:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julio Lajara <julio@tvisioninsights.com>
Date: Mon, 9 Sep 2024 16:57:23 -0400
Message-ID: <CAOrC7GfMagHXiZ3GzxmPMRgguWi0g1rUgcpgQFYHstfkaSstBw@mail.gmail.com>
Subject: Initializing bluetooth using socket.c userland functions broken after
 upgrade from 6.5 to 6.8 (and mainline 6.9, 6.10)
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My company uses pybleno to initialize bluetooth LE devices on our IOT
devices as GATT servers.
This has worked fine from 4.x kernels on Ubuntu 18.04 up to 6.5.0 on
Ubuntu 22.04 for us. The Python code interfaces
with the socket.c userland functions AFAICT.

After upgrading from 6.5 to 6.8 kernel on Ubuntu 22.04, the kernel is
now returning

"[Errno 22] Invalid Argument" from the socket.c setsockopt function.

I have outline as best I can what I checked in the downstream pybleno
ticket here: https://github.com/Adam-Langley/pybleno/issues/63

I could use some input on whether on not any of the recent socket.c
changes between 6.5 to 6.8 changes could have caused this and if
this is a regression or whether not the Python calls to these socket.c
functions which have worked since 4.x need to be rewritten as a result
of an expected interface change on the kernel side.

This problem exists for us as well when we tested with mainline 6.9
and 6.10 kernels last week and our only current solution is
downgrading to 6.5 .

Thank you,

