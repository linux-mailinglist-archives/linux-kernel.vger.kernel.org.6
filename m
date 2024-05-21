Return-Path: <linux-kernel+bounces-184351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711F8CA5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ADE1F21BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6915C13D;
	Tue, 21 May 2024 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MECzBY10"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8D5C83
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255952; cv=none; b=ITC0xp3DXeUiCRDceByFdMWyt51UUk7Rn9ZDJHxPU2vZO1NAn4s9Qm9HyCrYG+18O7+HjFlw9CnD46518H31nvJw4X5h94x4ehL3e/SqpaE2oOP7+lm9BqoBrmCY++4VW/NNQ1OaB10X7kO/ggqCogwDcw5f1nQJvNAxtFTfCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255952; c=relaxed/simple;
	bh=oZFAf8H47YsBfMns5GhBYaCcXynGiqCDxTu50hDTBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+k2XqmVCMMn5wIqkf1WipXRIg3EEQ/6bq1REKWyMxkyme63lK5Nn1/ZG1amw4s/7pAz171Y19XlQmpHjceTlRPP8mwJ46/Z59MMI5rCtFf3jW+rFJMAc+39u3ANjVl/wTRuzgEI6Z2SnwMLDQFH33KGyVtCg8+nif8yM5IBT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MECzBY10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716255949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlCkg0tP4Cpfzk2bC4YEhkvWskQ1DD1aHNtJblqbcpg=;
	b=MECzBY100HCXpvfi13TJm642zigzC9OV3e+BHKDW5yhuYP/SbB8QXH+nP3YoEaaBAPFuJX
	PD4DKbIFJTLrfYNhLUmdmGHKZlbX9NreZMcDvaPIwKrF1N5Nr4ekTmKipMRlbiLrq2vWOe
	59vOAYZeGsv3zQzgEBYKLgo9Pnb37TE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-nZZk4lPEPxelR0d90P3_9w-1; Mon, 20 May 2024 21:45:48 -0400
X-MC-Unique: nZZk4lPEPxelR0d90P3_9w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6658818ad5eso2253038a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716255947; x=1716860747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlCkg0tP4Cpfzk2bC4YEhkvWskQ1DD1aHNtJblqbcpg=;
        b=cJB3BDokzvfU5hVPnwSl0TpXKfFtxRZW8YVnUzB6aDXUV7a3XGim/ZjuAU6B7Zeyfn
         innfliJ2+PXr06wjdmlOO7YBpCqijeQ1RNRHVz7987HHPyMRslJs0JEw4SdHj67U6X0o
         Vedw6ps89dbQH+6NSk5zwBKwOiQ7hy8c3H/z4kYXDvhbEJV/GBYmMvRAcY7+Xj2EvLPv
         S7INBWNy19Kkk4jiRzgQ4M4QVF5fonnbSt3+bTNRr5/FJ0Kp23tZTa2cTucUPkAnoliE
         03kSFbxSPIPsIGILjUn9M27wbOeIogm+1zYMgxXuE8ryf4sXm1owoMo3gvsanyrR8dkk
         EaRA==
X-Forwarded-Encrypted: i=1; AJvYcCVkizYV4UUm0TVAv/TjNTZyUDl4He810SWDkbVmFRBSPTNEHLf9E8XvE5JiiWLLb05MMaqoMo6LG1ly6zioolvNhNafUiVDf8UjSAw4
X-Gm-Message-State: AOJu0YzFuS0O1zgRIObY/GIZS47kgQhpcvUuDdwq5XwrzDetSbSSFKhH
	/hrCh/QaiHHfg3w0VckcR+1gMOSJtg5TOVUimbwD516IotnfO9cIWWyiEcQWORo2EGPDXRuFESc
	RwUA9muHbGSEKmQSRFG50cYKKviLePjHODIUmmxHkpFsRxslNM/63P8Db8/uuGA==
X-Received: by 2002:a17:903:1208:b0:1ea:bc:53ac with SMTP id d9443c01a7336-1ef44161e5bmr341628855ad.44.1716255946436;
        Mon, 20 May 2024 18:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5g1E6nTlKOP21DL9Yzz2/p0qfOZR9sXI4bI9iM65GYg3ScXNcnblgsFIFUW7eoYcrmNjhw==
X-Received: by 2002:a17:903:1208:b0:1ea:bc:53ac with SMTP id d9443c01a7336-1ef44161e5bmr341628485ad.44.1716255945389;
        Mon, 20 May 2024 18:45:45 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30c391ac9sm4521795ad.37.2024.05.20.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 18:45:44 -0700 (PDT)
Date: Tue, 21 May 2024 09:43:17 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>

On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
>Please don't add dm-devel@redhat.com in the public list because it's a
>internal mailing list or aliase. And I got error when replying.

Thanks for the reminder! Actually it's a public mailing list and you
can find all emails publicly listed on [1]. I did some research and it
seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],
> To post a message to all the list members (who were subscribed with
> mail delivery enabled as of 2023.10.20), send email to
> dm-devel@lists.linux.dev.  You can no longer subscribe to
> dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> send email to dm-devel+subscribe@lists.linux.dev.

[1] https://lore.kernel.org/dm-devel/
[2] https://listman.redhat.com/mailman/listinfo/dm-devel

-- 
Best regards,
Coiby


