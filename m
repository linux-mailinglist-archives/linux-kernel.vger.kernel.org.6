Return-Path: <linux-kernel+bounces-303858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FA96162B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FCF1C235D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C01D27A0;
	Tue, 27 Aug 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2ac4kkM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938D1D1756
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781494; cv=none; b=qj1UQbRL/LSVzGq8P/HRzdFuaSBs7lHMp7G3o2EUBzHkNX9LS+j6sy93SpaGbksU4AALJqg/8vUZ3QOHDe7/M5zQx5jbW66ZDa5fC2jJ9ucRMxJg2lkIu3YLEG3H0GekNChxEsfukbr9PWeQfKiccN0t9YaVEAaYVJVRw9ZKWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781494; c=relaxed/simple;
	bh=fGB1KEKEkPkSR3Ku1aCpn1uMlK36034kJVp9jm5KFgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkmIwtD9TnEelWa4zKDuFEpKBdnlYY8YJSDliPlQCPLFJGuTgpQbCPNSlHClGEuWayOwg8a6PN2Y3RTvNnHhoWbq3Go25S4wA85nQR5Nr/37pIPTklLTfOG3lVgl18Lq3sZgTcPUN3e+XnoUSjTrMyhr37Wv38gijb1XlWGVJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2ac4kkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724781492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNE55uiPfv0rSAnNkK+dDLxJioGrxTnawTlM17hUAPo=;
	b=i2ac4kkMXaiVIFkyEx7XeVpkApQugEVaK72bHGGYPXVaW4Lm3KnBptFBuvp7+ReFui0eJb
	zUGjNmClq+TGzAV7l7+pPXwCnnq7ajaBeY/6q2iEwxyzPDkNN1Okf9Nb7wOfnMUkvXuL0W
	JpddLvOwh7REgePUROLbYFvveCsvifc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-0ZEyCeDXOd6WtxnRAFdcuQ-1; Tue, 27 Aug 2024 13:58:10 -0400
X-MC-Unique: 0ZEyCeDXOd6WtxnRAFdcuQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6b2249bf2d0so119212577b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781490; x=1725386290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNE55uiPfv0rSAnNkK+dDLxJioGrxTnawTlM17hUAPo=;
        b=qVEWE8u/CFSwY/vYAz+EYysiUgKPxOI64LVbwTfoqe7qCwKeWWep4hkNMe3SM5XwuP
         n8TZ3SsKzlu/02sd8sKd8u1WSjKq+mk9A3BfOgO/p3PXQCb8k5gDOMk1LPaUfUZH2bxL
         tb69nrua1+dDfb8zt0Mk4t6vNPNTkYaGj3CpEGs87YqBxTMF8Hwg9UJDovGrkMa6xuIu
         yEzVvB7zW0+/YjBWoHc5X+3T5EPbr0N9XmOQKaecZgOEkCYE1alEZJ2YrTWGk4jIKhX4
         tzqBTyGeLHzi6u+MutR1a2TF5iNcXkpfLXcyQRv76dn53gCT6wIhBN2PpUxVrxbFfeq2
         0n6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ns7ymIp9uBDaDaEmx0H4EXTSDdzFOKH9QHCA5h+xNyRxEqy4vjcC/Xi5lfhFDPqnKQ9RkXsvV1CUjTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+G9Ohvd11Alut6cvKXVhyWZetxq6WZzztnRIyPO+RsKu33yy
	QjC3LujQd/xfnMkmuwZS9uUbvgiXS78NHvFwGH9S50rmZTYUjBWmzw5CWbyh11l9pesOu4LMHFr
	+LgRXuBVjF8LmTfakmf1Xpwin/CNeu3v3w6F9dwy5jh18qfIekHvU3uAfS8ezFw==
X-Received: by 2002:a05:690c:6612:b0:6b3:a6ff:76a3 with SMTP id 00721157ae682-6cfb9dc2254mr38654567b3.6.1724781490118;
        Tue, 27 Aug 2024 10:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy81mn28ojVuK5Ks5wF0coC0hUnupw8DfXK3JRQ+ewZNXwflOkyOQQt5b98Z5LmX+zys0bRg==
X-Received: by 2002:a05:690c:6612:b0:6b3:a6ff:76a3 with SMTP id 00721157ae682-6cfb9dc2254mr38654377b3.6.1724781489854;
        Tue, 27 Aug 2024 10:58:09 -0700 (PDT)
Received: from rhfedora ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753839sm20198267b3.50.2024.08.27.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:58:09 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:58:07 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <Zs4Tr0AzOqNNASGK@rhfedora>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com>
 <ZsQ6XKQ4pRFYkGoS@rhfedora>
 <c7259d79-4e66-48c2-922c-f6ab88b3af69@linuxfoundation.org>
 <61b180e2-6c88-4047-bad9-4d712bd5072d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b180e2-6c88-4047-bad9-4d712bd5072d@linuxfoundation.org>

On Wed, Aug 21, 2024 at 09:25:52PM -0600, Shuah Khan wrote:
> On 8/21/24 01:08, Shuah Khan wrote:
> > On 8/20/24 00:40, John B. Wyatt IV wrote:
> > > A quick search for bindings shows what I believe to be all of them for device
> > > tree. This may establish a new precedent.
> > > 
> 
> I don't fully understand the above. Will this patch series include device tree
> changes? I didn't get that from the RFC.

I miswrote. I meant I could not find anything related to bindings for a
user-space program in the kernel repo. Device-bindings was the closest I
could find and it is not relevant. My apologies. Thank you for asking about
that.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


