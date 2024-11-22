Return-Path: <linux-kernel+bounces-418709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29259D6493
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BCC160654
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E01DFD87;
	Fri, 22 Nov 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCrFiXc/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9C4C62B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303725; cv=none; b=K280p7ulql91U8rqivIdnFF7lPvoHqh5ZtrIJRTDMn/Tr8Y28t1wu+lASTYbRFo5Rc630b55YuZ7G7CLVSS7WeZ5C/d4RssBqimJRBZ2bwqi7vAsgkpKLAPWt8D4/4pnw82I7OGvcbpsVtvVbbZqSkhMd716kV/LYFvEioGdL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303725; c=relaxed/simple;
	bh=CIirRwIqXxswoKYw/C0vt7jhR+LbI6hwoJRM9Kmjx0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIxxOelBcJ5+QkjHo8d2wY00aulPnCpI0mROPmr617Yon80qSfZ6vHw2mNaAHII3ZWwJMq1bpf8NwmdVsjRFd0e+1UZ/IczuBH24z5dtOwxMXOyPn6D/F4ISr4P4ELoKfWPZx/DTmV1oE9ZLD649K5v3GQktxm45lYTdhbqR/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCrFiXc/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732303722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FcvGsCpkjrQ7syvCrJLvbT9jNNGJMzuDnZMicFV+YWE=;
	b=NCrFiXc/YJ7d9K2DUJF5RtSWnDCZf8X7Qx/yREmDZCXu7kiudZyxN7C1R8adTixPWcPdjO
	yz/6iilXSptnkzwQk3hShUfZyJF8PMT0sWd+ly/1wZ7i4BKw/YR/+q6LcV/TocdWE9otj1
	LTi2Mexz6G+YKp+MsifrVIAUlnYfGYY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-YZVem5HzNBOaAC51TXNjkA-1; Fri, 22 Nov 2024 14:28:41 -0500
X-MC-Unique: YZVem5HzNBOaAC51TXNjkA-1
X-Mimecast-MFC-AGG-ID: YZVem5HzNBOaAC51TXNjkA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-20ca1692cb7so25831375ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303720; x=1732908520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcvGsCpkjrQ7syvCrJLvbT9jNNGJMzuDnZMicFV+YWE=;
        b=NZz5l+oI6HqFDdQx2RgUEQvvoDwUDfbAiuDo9WLn/4HwKduW8wAiHRoghtXqhRvi4U
         K95uZ/UBEnVyElUJWVChA1CSH1XAhcXOATOWNZWbRlwB+qkigeP1zcOvJWiXU628/o+X
         rYEHhydoaoIY6t5zOTqJMWR5spIMOK+4F5w3f2/jEmRCozU22Olz3iqAiCqB2WiBUAwb
         Mw0ON9eO47jjvZH9nakX2LLex0CTVyklqzoD9nC6RFEDIF2nnnTDBALTrOpFD6+GG6/Z
         PtzX702zf6FR/s8F39M2FwXR41TKN/4UD2j7NswlfclC+CY7s+fp10WrM5Ft10odiTvf
         dnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN+LVUI4dKGUHnwkbBOxoLJQ9MuM6FrZ7qS12JmjOepIif3YBZVpHPX1st/G/BXh0+FFgZ2HanEL/tx5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6wDtTzYAjDsZfFJRazjo6POc2H62UMfzjDh8C7NlTux5aI/6
	8traORQt4H+YWDT4oaAO5fh7aAQgZg7/7XzPtLJ04LeHrkm98cdLkHWJLsytXl5nJGTTiDT59l2
	2idrL3xI5Txqfeug/yaaDdZs1W1uOt10wx32YhY1fbu7zENZJi+JOeUY1tXPMig==
X-Gm-Gg: ASbGncseu1+bYUyCpObEIcOAJSc9rw5eFUszIi11DUsASZpr0I8bj9uGQqXLQiplr3u
	A8eqyFfCjy4zmZdCVhklKOBC64RQJ1mf8CzsJOGS23otrMr8Yw5o7KxLtdwAL5gUlgBGvPVShZs
	IrdVhVjTT8HponjvQNDnfrmIK+bn7p3jbzz03E1LpsuuBnyuWlTSUrGtrkTtlqkw5s7eA+8/zvq
	JNZbwKpOj5vEUwUH0Qk01oi0FbHfIuPheuwwD6Ov+9xF6GhhPVHBgZMnoimWS8haJyt0eNwBUUm
	bYyTgl8i2yNfkxQ=
X-Received: by 2002:a17:902:d2c2:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-2129f22647dmr50381785ad.19.1732303719890;
        Fri, 22 Nov 2024 11:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiZUUX5sdsIBj7jPZBEqjq3sJYV/CnWD950OlpmmREi6SjKqkBB0USD/fBz0GQhMfKIDS+Vw==
X-Received: by 2002:a17:902:d2c2:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-2129f22647dmr50381615ad.19.1732303719599;
        Fri, 22 Nov 2024 11:28:39 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8f7c5sm19899885ad.44.2024.11.22.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:28:39 -0800 (PST)
Date: Sat, 23 Nov 2024 03:28:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] kernel BUG at include/linux/scatterlist.h
Message-ID: <20241122192835.rsryoifhczqgmjf7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241122045106.tzhvm2wrqvttub6k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAMj1kXGAuJSdDWvu7D5-PT6mSbNG9FeLObnYmpHeT08eNxaJWQ@mail.gmail.com>
 <Z0A2W1FTTPt9PeI5@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0A2W1FTTPt9PeI5@gondor.apana.org.au>

On Fri, Nov 22, 2024 at 03:44:27PM +0800, Herbert Xu wrote:
> On Fri, Nov 22, 2024 at 07:42:54AM +0100, Ard Biesheuvel wrote:
> >
> > Does this help?

Hi Ard, thanks for your quick response, do you still hope to test
your patch?

> 
> This is a bug in the API/driver.  Users should not be expected to know
> what kind of a virtual pointer is acceptable.
> 
> In this particular case, rsassa-pkcs1.c should be fixed to use the
> crypto_akcipher_sync_encrypt interface.

Thanks Herbert, feel free to CC me after you have a patch, I'm glad to
give it a test.

Thanks,
Zorro

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 


