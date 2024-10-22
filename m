Return-Path: <linux-kernel+bounces-376365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B69C9AB060
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D9A1C20FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845919F10A;
	Tue, 22 Oct 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fuLQxicX"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8C139CE9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605965; cv=none; b=JOIHuHT2nEZPCVTFs25sm7iKazWuhR1OUAmJbZNOuw0xpC5TviZARCMC/6Ltw98UbHLOeVyFrUuuJPq1GRv3EDP83hnux/7o7oFmjX0GCIAzRL9c/n+CSVaB5//Y0waaT2CEbjunIM6APFoB0Bh8viyU/ydIp3zrnDZt7EoHXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605965; c=relaxed/simple;
	bh=VZ6abSXXdL7OBXrDYbe6irIZnn/ZfdHgaS/ckd1GhDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SME7o1iKnbXE23HpV2yJ+EmqntUttrMIJ5oq+DBlEif0WWbObbQPGwHeA8WY26iP7C88Uzkk5NUngA+gq4nPTnU4UwW0QZfe95JRpbcctlFUh3bNh5v+Qx2Ml+HpDi13OD9c131izzQ8/DxeGTPQC8ov0QTJ0FxFEzPqSu3E1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fuLQxicX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1511697a5so364039285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729605961; x=1730210761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbSnBGbFWyqRgNTgRUyXWcx49M0WCk/TnLV94eW6zWQ=;
        b=fuLQxicXDo7bzO0HLBDeWQznXT5Cbd5H5w8gDmT2yq5/uLpMfkOo9b9kaFgGu4ebX9
         q8illgKpDerflJmtkeznH12cfF8CP0hbPBCQxzVzs7/jinwxVqBrdzeEffuns70dGmHb
         4YcdhNCxkcA8IvkOiPDDclwveSrvNoMvDDJ8j+9fqi+MCO2m+XTlxQ3XXedQh5AyiHfA
         QsB2e2n82mSok9IfXzT/OooaBvtNyeSEYO0QQP94ugOPCsKo0K5/6ujkSE5UWydDDou7
         BW++gZvMxi+X53E+owCdSytk/tEIRpOwNDxHEVTm6fp9cS7dhShhLEetINM2eXy+kqIJ
         89xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605961; x=1730210761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbSnBGbFWyqRgNTgRUyXWcx49M0WCk/TnLV94eW6zWQ=;
        b=QuEQW09KxUKvJd53ZMDsziN8gey4pAZAP0CZ9X25UoKO52QGn+Mj1hR4e9+JE8uR3d
         wAUH3eNRYOoPErqguuvzrNLSjRRRMU1I+Z/8Fv96NvJyvxSJvXzNGdZ941LhgN+5oehZ
         DT7z0R2rogbFHC1DSQV0U2REUnMZWBlGzEv6m6l2A5S6aQykNRL1bhNhUARQY9maOi4c
         qrVa+rAj9Ta4quWAqbKUaT3VqGfQMc8KwjcnNz18x1zNDd4snsOgPt0nxYABT/vdputh
         SvtR1gSe6QPzRAa5OflCl1f9AWK30CI1TY3r36c9jbYMgQ0vqwXhTtOOo5EGxpRI/Z4F
         XCPw==
X-Forwarded-Encrypted: i=1; AJvYcCVOhchZKjjQiXJqjS7ymM09IJRUUzNrs0BpgCtROart00SqxMvPi1nqqXp1UDz+0aNnCnrIBhB6d06Qul8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQu8/7AoIMHXD0IytitxbxpAMd+Ekgj22XLHOMzDsyA9TI/KJ1
	bqzXRdp5T7L2mqNybGKsNh08+0mshmm4CAMtGd+4FobxvNgnwyQRtiGYzqg1aRI=
X-Google-Smtp-Source: AGHT+IEgGsNh+W2oLEbTW0uW5breigomGJPTIkJX5Ksh6Do8w+7tAga3OXpEpeS3XkgQFgDKJsGl6A==
X-Received: by 2002:a05:6214:5785:b0:6cb:3a1f:e47b with SMTP id 6a1803df08f44-6cde163e394mr169245556d6.52.1729605961181;
        Tue, 22 Oct 2024 07:06:01 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008aca25sm29087326d6.6.2024.10.22.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:06:00 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:05:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: shuah@kernel.org, surenb@google.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Subject: Re: [PATCH] selftests/sched: add basic test for psi
Message-ID: <20241022140556.GB219474@cmpxchg.org>
References: <20241022122158.2136-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022122158.2136-1-quic_pintu@quicinc.com>

On Tue, Oct 22, 2024 at 05:51:58PM +0530, Pintu Kumar wrote:
> There is a psi module that exists under kernel/sched/psi.
> Add a basic test to test the psi.

I'm not sure this is a valuable use of test cycles. The mere existence
and basic format of the files is very unlikely to be buggy, and such a
bug wouldn't hide for very long either.

> @@ -18548,10 +18548,12 @@ F:	include/uapi/linux/pps.h
>  PRESSURE STALL INFORMATION (PSI)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Suren Baghdasaryan <surenb@google.com>
> +M:	Pintu Kumar <quic_pintu@quicinc.com>

$ git log --oneline --author='Pintu Kumar' kernel/sched/psi.c | wc -l
0

Really? ;)

>  R:	Peter Ziljstra <peterz@infradead.org>
>  S:	Maintained
>  F:	include/linux/psi*
>  F:	kernel/sched/psi.c
> +F:	tools/testing/selftests/sched/psi_test.c
>  
>  PRINTK
>  M:	Petr Mladek <pmladek@suse.com>

