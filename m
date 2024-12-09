Return-Path: <linux-kernel+bounces-437204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8289E9047
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71081886821
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188C217727;
	Mon,  9 Dec 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IxP4kqr+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1C217721
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740429; cv=none; b=t8R6cIQmw9tMhqlxf78Ew5lK97c7pO/Kl+HRiMr0OMiY1LDNhaMt6Bg9GAaeiPKx2t0SmEba+NTez8BCSTUAOQ3Gs74GAPNhxGE34bP6lYuZ4iZ6XifZXzloMNi3rrgrBVISIQ4JHlEiMbrw0ynGAVKVFlbbINrjYda2swY2RCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740429; c=relaxed/simple;
	bh=hGUNkPAiGXqDSa7dT0mfVI5e/Of5hnaQwknDb+vS7nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/1XN1ySREaef4zY5zCDPY9PKYX21uy0UT7RiGfcyWFhVUw5239vbIMvHJ28lTRpXNtKvqLgDnBeWYG27/6q8urywTcPCHKG9aUsd9H7VrMqQlmGRK2jZ9ltb7OY3CD0o9wVBRcE6wqAlZYDfSp5rMzyxk0M6czB+K7QTfxUUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IxP4kqr+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1836289f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733740425; x=1734345225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO4nLx0kfH9s6VR/jADGyHU7Uf5zkyJtN7uAkPweYn0=;
        b=IxP4kqr+knA05dewRXP352kR4vz/uQ92QRo0hjAZcwY6Y0gVSMdurW97o38J7nKz7x
         sVmGTnbJgJCL5EZhQHePfzk0FmfRzA8pEcGwnyxWzLxqoIEN0MGTK4EFJ+lu3M6EgKDn
         +YHRvl5Xq2btDL4J1H6QiFIV77EVTcWqM94lqaZ6OQav49EZ3i8Y3ni3KQfsMQGG0p9v
         PL5GtCTrAW3ayTmJzpOF7EVnGGJyYt959kzDkMyRmWiymAi1ErFh2Wcqd6p/ezwvgxFh
         MYwFy0JqAaldsCThAOlCoAsRzWCZNpbR43nsMSl+IuszkN9jZ/pCrV2Cb+Seyu5HSTBG
         A3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740425; x=1734345225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO4nLx0kfH9s6VR/jADGyHU7Uf5zkyJtN7uAkPweYn0=;
        b=Kl+L7W2lH0tR6t26+lxcyetRgIbJ6QlM5JCW374IYqtQ4/om5H5oQ0ulC8ttyw/BQR
         rzBONuWas1sMjEB3gIilU2lcmBNlp7JiuHptrxo+EhhAG+/SyqIR3baBZfDrfbC8lDgz
         oUdH6m35y5N05opWirWCkyqfAtMWOawX+3ypo5VkJXzQAKZj2OI0gBNZiBsXxnTDSkRc
         SkSbaKRrSUE3Pj63hhZ7ESigvhEUSILmq7Wp98ovrrnBIqcJe0R4OIYiXP4ON5BIYFYf
         RVluZxre1qoDZ5hkFruMjQZ8bS5jZTEAf2xHb5OVMnGn23gVkGapIY+4hwKi+K1xphuJ
         rxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXysZaSmtGeXYV46BJrkGcZ5YzKh8ScNy0n3l83cEjNLGVKCj7bT4fwcizRcUAxZUihuFnFvo2xz9RhUDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZ1l3K3Kw/mQ8LsEZ5DbudpDy2j18D3fNO2SsMOyhXuKzdwsz
	IElgFzC88keqbqoYJC1fyN8xwunL26F4oCPsajTrvYTQmdIekcz72fxdJXAzlYA=
X-Gm-Gg: ASbGnctveSnG2O3tmmCllcQQUdp/rCPdECaG5bzz4RWWVmVZrnwqOwg6BFXfSt+0Y3q
	rRROQbKn2j3zKi43ySmB246J0u1Ao0OAYo3AuNm6sVL926YGL/wDL0Ii+DLnI9e2q+RU4/qaDgT
	ertFLBRrz4y2aVYshVIeyVOPEh4Mv4Kc7lk1LVuP5CVyrxLg4J5/rZG6licXuqLaYRvuJZRb4+N
	McHYlEPfRKn6f9QbGbCR369LamjLwx3eaR8YgxveikgIORJdpc=
X-Google-Smtp-Source: AGHT+IE1Mq2p1wEAoDyK2ADS8QG2njkoPsV/DcaIyc6/bJSThV8qrxTzCj1DyCksy6aEjoZIpmshjw==
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr9798912f8f.5.1733740425377;
        Mon, 09 Dec 2024 02:33:45 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f3e936ffsm919093b3a.132.2024.12.09.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:33:44 -0800 (PST)
Date: Mon, 9 Dec 2024 11:33:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace
 hardcoded module name with variable in test-callbacks.sh
Message-ID: <Z1bHgHlMuc_H3L5R@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
 <20241125112812.281018-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-2-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:12, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Replaced the hardcoded module name test_klp_callbacks_demo in the
> pre_patch_callback log message with the variable $MOD_LIVEPATCH.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

JFYI, this patch has been committed into livepatching.git,
branch for-6.14/selftests-trivial.

Best Regards,
Petr

