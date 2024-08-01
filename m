Return-Path: <linux-kernel+bounces-271881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4494546D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1C31F24453
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15F14C59C;
	Thu,  1 Aug 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aptinwgG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978014B097
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550351; cv=none; b=MFscNKNjUiKJu0j2uWGlv6+zVs3Q+BLIRE5HoQsuFpz1GgoSCNs2ehwesdODc8ybnimveUA3oy4CrDWvSy6TBxZTobPXwWAOx2g40RFMomxv2c0g+9dGPEAXLc42qkUmsRXbb8jQfJ64aMRWZINRI4+uG23L2AeTULWbd9BYqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550351; c=relaxed/simple;
	bh=0UTEUABwLl9nPHyasmA3Zw/bHjsSB/lUKnDNzfoDXeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlVBLPNAMUiwVL963ry0hfmMpucqROMmvjzXd2P0hgkVC6RxzYqk6QrAa9XKUjYVj6yPHQ9AzggTHzBg4J52sEBFtKF/VIm0VnnMT7of49yZ5FEygGAueP1zxbyEtLpzBzhLl28BLqA+UxX9q1dd0TRNCsuFlaDDDVWH9iq9AyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aptinwgG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722550348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oEkakUjv0oShqAlgA+JoFFoT773rpEPOk5LHphGKBXA=;
	b=aptinwgG7JR52pzVDkfbNDAztTF0hRKIRdBDAy8YcFHRH/IHMWw584zRAs+Da8LAZWWgcN
	caRY08UPBJ6S/U11wSD0C7DZk9EjpUm9tYeHMEs8Jfw8FkN/rdwk+GjHE8We0Ew10gFqXI
	oyWr5USrgPHYNVVd7Mq/h26qvCm3apY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Tp7WBm-IOdauqMg6PbnsNw-1; Thu, 01 Aug 2024 18:12:27 -0400
X-MC-Unique: Tp7WBm-IOdauqMg6PbnsNw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b798c6b850so10409656d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 15:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722550347; x=1723155147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEkakUjv0oShqAlgA+JoFFoT773rpEPOk5LHphGKBXA=;
        b=NzQVNboLkdx0zAgM5P3AkYLC4At0ClaMgDE6nTe5c+Lj5Q1tWNNDYkb5sXbmk6gmXt
         K9MKX9pAjM1MU4WWsgd2lkGitwZgELHCA8OyKyCUpAsxmJUgsGs47sj1mQrkwzk9vHlp
         54sTrp8S2X+cgvQWe9ZY8C/nxMu3VAGD6wWtDZHI2na0ZEegddFVoarX5M6Fko3+gA9X
         xNnHacxjv0b73s1gYknN5u8n0yFVRJ8i9seF0iy+RBGFI0RsZg+wv21H1Zxg78jqhK+I
         qYSSuNFJVSvlVctDwN3RTS5wcqYuWGZBA0YAxOAvbbKXyEViOzRNytIUBgsI8N8/whIz
         fwFA==
X-Forwarded-Encrypted: i=1; AJvYcCWtZRyvrARKF0CeZB+5fbVpNr09KxlnW+l0K7Iy8EUp3LFaGiWIafb7sQvqOocCRLXhw5Nas5Til+Ekx1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BI3j25fhzTMbzV2Oa0qVQwsZYNMsgt82ps2QXGCb8YzgA78n
	w1Vy4yxV1M8LzgwEy/2f5+DT7Cz60HZg8idVWqs3H0blK351EVmOLYYBf8iaIYK9VYOaBv7cUFZ
	Wp3lQkmphK6pNXJjJJxtyaJ00blLyVGHIeqqxCbqcD5HfqIQVE6QhvQnkQj7o4A==
X-Received: by 2002:a05:6214:c48:b0:6b7:586c:2cf9 with SMTP id 6a1803df08f44-6bb98477071mr10740606d6.8.1722550347296;
        Thu, 01 Aug 2024 15:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYiPlQnhQgnszBxOlYnmcmzkuBRtiLsO/YtZH3gTULjwGEVWYGXNe4E6cY2VjLct5v9IMvig==
X-Received: by 2002:a05:6214:c48:b0:6b7:586c:2cf9 with SMTP id 6a1803df08f44-6bb98477071mr10740356d6.8.1722550346938;
        Thu, 01 Aug 2024 15:12:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c77099asm1039296d6.12.2024.08.01.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:12:26 -0700 (PDT)
Date: Thu, 1 Aug 2024 18:12:23 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [RFC PATCH 00/18] KVM: Post-copy live migration for guest_memfd
Message-ID: <ZqwIR8HW0d0cXAhq@x1n>
References: <20240710234222.2333120-1-jthoughton@google.com>
 <CADrL8HUHRMwUPhr7jLLBgD9YLFAnVHc=N-C=8er-x6GUtV97pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUHRMwUPhr7jLLBgD9YLFAnVHc=N-C=8er-x6GUtV97pQ@mail.gmail.com>

On Wed, Jul 10, 2024 at 04:48:36PM -0700, James Houghton wrote:
> Ah, I put the wrong email for Peter! I'm so sorry!

So I have a pure (and even stupid) question to ask before the rest of
details.. it's pure question because I know little on guest_memfd,
especially on the future plans.

So.. Is there any chance guest_memfd can in the future provide 1G normal
(!CoCo) pages?  If yes, are these pages GUP-able, and mapp-able?

Thanks,

-- 
Peter Xu


