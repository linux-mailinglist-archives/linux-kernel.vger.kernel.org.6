Return-Path: <linux-kernel+bounces-536623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22AA4820F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6F719C7129
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F423A9BB;
	Thu, 27 Feb 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBPu+ydk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724EC239086
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667420; cv=none; b=RujL4um6cTvvSsxdgi2m0U+LRTmdDQva8wYD4FQKzalvyFIjLLwMkpeiZfn09+MVNQEgQub6qSNfn1W5CYRO8+6eNmNBG0Cpo8xtbcJHlgD+ju8F6/YVlcIvrbU7nei19KbWNSp/1TZdFyLfQ6HN0r9pe3MCGW/2PYdJBR1we94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667420; c=relaxed/simple;
	bh=SFThVowJlqQktHJLgxbc5ykucEGjsXXMh/7UDNM/BO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdWopGRbbGV3GZlqUgxjhjrjuUNy3yORAeCnAwFIgw3hLcFuBL4BXi7FXdz0ZiUq8R/8PsU/qaVMomZmQvCgK2qLhJVqFvDBdlT5TWVd7Oxv6K4mYvB6H7sz5NfutrbpHvYiN51FDoLSGbOVf/EmLbsIurnVpM+z9CBVu2Bst8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBPu+ydk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740667418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGiCMh885+JkNd7xet7ImHZf0tupK1uK6dAAvNVNafo=;
	b=XBPu+ydkkXmEtOA6vShfQ1RaStdhVRRjFABamTWb6JbOYy5m02EJaNMGa4+vmsInWV1KeQ
	ZdbbVR0J2fx9gFt/LCXxsXgoRhZJLKo/j2Krn8MEEwMxwiH5XNOEuueDm5zL2NDWjIEGPr
	K3Wtgwqe6CMUxE2+KAXby8uxXJAqf2Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-KLpYVj2yMBOWew8NWfeTxw-1; Thu, 27 Feb 2025 09:43:36 -0500
X-MC-Unique: KLpYVj2yMBOWew8NWfeTxw-1
X-Mimecast-MFC-AGG-ID: KLpYVj2yMBOWew8NWfeTxw_1740667415
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso639167f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667415; x=1741272215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGiCMh885+JkNd7xet7ImHZf0tupK1uK6dAAvNVNafo=;
        b=Gofgw2IhBGb6qP4QOnjC5pFMaoPLCkYq4MkWTw8OmpIsbAnDBB6kweFI0AfWu9I9nE
         pQstJOR7p4DR/0FwW+G1e/JMVaQbQHSDbikGSKcKJZYc66McPkTkANQncwxc7Jd2cnFO
         DsCU9+DgMv/LkeLs5+jfAP7gqsX8KQg+Tm9qYA2xtFRvwqNzJoCyTbCOVEYKbIBdW4h7
         A0dZ85qrwayopH7RGV8X75oMuxKPFhl4MTGZMs/JcbJDF6AvQokS6AqnR6FT30aGH+Zg
         VE5gqZbdheDktwjjIAsb4hgV4McNALQhCE/Y3tEwYkh4pCyDKx4Lkym5hzvJK0g8iK7t
         XCxg==
X-Forwarded-Encrypted: i=1; AJvYcCUvT8HLwGLc9Q9sFUn+jkpu3NLzMvrFxnMddOPbYX/NZV/yNkYgjGeTYiBB4eKtJu78LYa60gTbm1BwQWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz915WHUkyrFnXozufPwfIJ7+zD5y0FCKbqzivOrTdUZS/EkdDf
	YKcAlXb43nb1dtx4NjmyFV2XLDsk/Nin6tS+spAHaLkwcshfMlnNzaXLXeicIx0GnkLKbFsFAv5
	swoFdzQkywCkrOVpoJeU9QZK9QLa2gO2abDgSvw11kmbrKBV3bXsdHYptx3zaXw==
X-Gm-Gg: ASbGncuzwHx2m/+Lm3T6TYlI344kLduSQCoZjGbICZLLW+cj6DHQsYfuIg6IZG2Db2q
	zBxK980rPgZ2J/b7truq+R5KhM/HfvQXXI+QqF6jOSGIKf4Hg7cjYZ5kql2LYo5f66ZDtfzAjPI
	PW+RnqQlbhuMj5MHnZlT/HoQE/6fOVAsYrJbXEX9MtOAOwhAGpxCPwvv5qZb7CrJAfnpjQz8bqp
	X0ArqxmfmxxPzuabP5RH194GIXYN70pMY4TlcL3m7LlbvYPDVdFinYM2ZpxgYKu02D/+UPjUCR8
	t7NFatqfyRcGmtii63s/bs6t8e93T+cysfRHrNHgJOdp0Q==
X-Received: by 2002:a05:6000:4014:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-390d4f3cab3mr7399934f8f.15.1740667415231;
        Thu, 27 Feb 2025 06:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENhybFuiGZlHBwyKhH7QHjSknwxNyGmC2Lpy8aCMSt3PxeScxP2D5rAbtFR0j3oDHU3vaSsw==
X-Received: by 2002:a05:6000:4014:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-390d4f3cab3mr7399917f8f.15.1740667414916;
        Thu, 27 Feb 2025 06:43:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7850sm2304944f8f.39.2025.02.27.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:43:34 -0800 (PST)
Message-ID: <da1d5d1a-b0ae-4a40-907d-386bd035954c@redhat.com>
Date: Thu, 27 Feb 2025 15:43:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on
 afs_cell and afs_server records
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Christian Brauner <brauner@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
 <20250224234154.2014840-1-dhowells@redhat.com>
 <3151401.1740661831@warthog.procyon.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3151401.1740661831@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 2:10 PM, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> The remaining patches in this series touch only AFS, I'm unsure if net-next
>> if the best target here???
> 
> Yeah.  It's tricky as the complete set of patches I would like to post spans
> three subsystems.

Possibly sharing a stable tree somewhere, and let the relevant subsystem
pull the tree specific deps/bits could help?

/P


