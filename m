Return-Path: <linux-kernel+bounces-282184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3694E095
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227CBB21033
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B12E83F;
	Sun, 11 Aug 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCJcRoIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F447208D1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723366309; cv=none; b=D1W7OcU/dffYEU0FfNXutQPkWQRsmBuY9vSb0X4vZtj1UIloHqrdXsM2dqXnqHgAX/741ztwDzMrdYMqqCDino3eO2hYeWHsC2i+Oq0foSVwoNPXvj84u36hQYrM1PfNiD1l0O5hyYokgcTlETbgH7vZfzWZMp9t5NwoIBiEnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723366309; c=relaxed/simple;
	bh=1B5I15DMAAc8If4jXdpqKf2hcp5AongQfAE7XpPFObE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptFwPCUfOL+adbR+9XJ4uKpa8Pk7LtCF2uz6cnBu6BWs3H+W3u8g2DxlOJit5Gp/ZsUxrP0qkGUIYyn+IsSxi/oMHZLbsuUl0gL8VByKQQobwgWp9l4zb4YtarFT9FDLnQlEqTQ/rk6mEXyq1GPg2JyCYPI+LwKrG545rldYtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCJcRoIE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723366306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nO8zDpNtu5TNqECPQNAF0g6rVZ54IeB2gyr7WMkyB+0=;
	b=cCJcRoIEPLY48sLIRX/RsyAYjMSzBOPNwvh5aL941Ext1FKXtpQ21OmK3KLO7bS1B1L/4p
	k5InwJIxFSXqQ+vDLwFt0P2rhY7oQ5j1HHPniAN1cJtxtbselB8uN1yCDXWsdQALz7E5By
	MiVHILVyqXYPidlQSVuGdaAUYcVxQD0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-IO0_xXP0NVKQuLJZuWTYRA-1; Sun, 11 Aug 2024 04:51:45 -0400
X-MC-Unique: IO0_xXP0NVKQuLJZuWTYRA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a822ee907so296445466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 01:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723366304; x=1723971104;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nO8zDpNtu5TNqECPQNAF0g6rVZ54IeB2gyr7WMkyB+0=;
        b=p9CG6zFaYv+1gyg2lLon/YVUWvvKkW3AuXg7rKMe2wOSAbsjh3cIdrY406mRtN1HBe
         FZhKNfVKgEmUQLbMLS+Nsyh+e8lvRex2n2bZaTXXsJa2aYP14Oyu4686+gDMkRMp5art
         PjKqHHSI3+xOWpWHopQU4BZvQ7HgjzguC9rZiOHhUYbkGuFifsSzcLIJ0JubztH6ZnG/
         fR0FDs3RNJnO9eI1Y3SVVNzUac6qOcRSenMAjRgt3F4oMwnq1WaD6yxJBdgbUDal2UcQ
         jiRbPGbBbb8LcoSqWqeiXICLf5N5w772yEm+PlS2Yvzh9CmbD0/Ht33NVu+pFZHw4kE0
         dwXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdZ0rSBONjdiAyRNnyqXmL1cb9wElnpChYArh7WslTgvrpDG7CNb0y52sjktG3xN9l84x8iZ47BEFgutuWa6Nv4PugZ4Vt2nbkr6d1
X-Gm-Message-State: AOJu0YztDTdhsXF3mXJQ9gA+fY1zw6hPeuxkbCCShd9YEjRxEGb6KLg2
	qXdaoO65/c156KkAgV8poqW8yxL/+pXv8iYePPUCDIfR3ETUuaI614QqI6AZSpxRb3G8m1wNWKz
	ZhJZMk/UxatwnNuSoIE3PX8iYgSYYCTlTd8//2xLWjt1LHHuqoRzCKEAT86uYIQ==
X-Received: by 2002:a17:907:efe4:b0:a7a:8378:625c with SMTP id a640c23a62f3a-a80aa5dd596mr460885366b.36.1723366303956;
        Sun, 11 Aug 2024 01:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLTEoCLje1+/EozjL6GLfA0Ify15zjAfHJS26Fb5eQomnIUpFA6R4LxXVepKUXAl2+doTCQA==
X-Received: by 2002:a17:907:efe4:b0:a7a:8378:625c with SMTP id a640c23a62f3a-a80aa5dd596mr460884266b.36.1723366303477;
        Sun, 11 Aug 2024 01:51:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1d153csm132038166b.137.2024.08.11.01.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 01:51:43 -0700 (PDT)
Message-ID: <fae2def0-918a-495b-a89b-3a8eedd44b1f@redhat.com>
Date: Sun, 11 Aug 2024 10:51:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
 <20240809070412.33847-1-21cnbao@gmail.com>
 <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
 <CAGsJ_4z-bCSSQecYq=L4U1QuoQUCtgY1WXbAX=eCEO9rXv8eNQ@mail.gmail.com>
 <CAGsJ_4w0SzyA50zNcGAgUc36GOEVr3L6gcZntw4ejBogC9b6+Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4w0SzyA50zNcGAgUc36GOEVr3L6gcZntw4ejBogC9b6+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> the correct place should be:
> 
> @@ -1329,6 +1326,10 @@ static int migrate_folio_move(free_folio_t
> put_new_folio, unsigned long private,
>          if (anon_vma)
>                  put_anon_vma(anon_vma);
>          folio_unlock(src);
> +
> +       if (folio_test_anon(src))
> +               mod_mthp_stat(folio_order(src), MTHP_STAT_NR_ANON, 1);
> +
>          migrate_folio_done(src, reason);
> 
>          return rc;
> 
> Without this modification in migration code, my tests fail, anon_num can
> become negative.

I was wondering if we should do it in __folio_migrate_mapping().

There, we set newfolio->mapping.

-- 
Cheers,

David / dhildenb


