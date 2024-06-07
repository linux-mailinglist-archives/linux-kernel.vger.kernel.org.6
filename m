Return-Path: <linux-kernel+bounces-206039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45490038D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A4F1F2803E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE637192B6A;
	Fri,  7 Jun 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0atu5z6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487518F2E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763281; cv=none; b=mEu3sV7lwk9F4Foin7qnb9ZI141GZh0Mi/rhTJVHAOwwULU4EXnNrMfYUWRdjlCVlpMKxP41VtXJ7auTmkQPTSySRrcA0QqT6Re5TIWVJIcQG3E2fieLmDCd2b0idhfS99oQkfr28AFJNqLM3nmfEBHJaukZcHkpY3Ur8UHRoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763281; c=relaxed/simple;
	bh=5ga61JYu4QS3wCZ+Ofmmy+SHrQ3UEzZ4Yu/0S9Z7di8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QreaT2wE7Kks3ojehfpft7EnIWpQhqx+QKOH/dqBGAcS85F78/NTExA57cv4OSHnx1HF/BEgbYTUf7b0APz94prcCCjqAT2cVoemKNEqtnTAWVjjnzw3CDLVnluyphuKSnPAFizsiWchZ3NLBw2/EhmFOByXZpmB5IFe/fZnRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0atu5z6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C2Z+9D3XMToghs4HAhDCgGVwTyyKde4buT3Zr7Fkmi4=;
	b=Y0atu5z65vtDd8L6KIgdJubuxKP0OwDoEdvi2g+CPkaL+zYuiD8H1f+FXdCPzFh+Y3XbCY
	k0LF2FITLKxSjm0jbabCGeVpo0c7UCjaTMGag31qG2UUosHlCjKFk/a1OCjaXboshhtexo
	6wdfM4koLYnwmBi9Xe2lCr0fbv25OEU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-iDGHa7-HNseN4L3uDINzJw-1; Fri, 07 Jun 2024 08:27:57 -0400
X-MC-Unique: iDGHa7-HNseN4L3uDINzJw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso170485339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763277; x=1718368077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Z+9D3XMToghs4HAhDCgGVwTyyKde4buT3Zr7Fkmi4=;
        b=md2XQQIICBdD0Eoz+64Fg+EPgsW0U8A939Hbu6qwl3yu7ZS1wgAxriOaF0Hc7nCGpZ
         JKHgKZ9QR9aEyWvMdKAZkKIV5oamTxkc3Tk/8zXzvacgLTx8dwLiyK+yNu8EG37OlcFm
         lxmd96Lg9BUpTMc8okysvFLkcw/QFXG6ytlLmwSZ2nv/sN1seVucMaGpGb1ntO2ntks+
         zlfF96gfc6/RrfMZptfZj1Jm47iY3hnZfUWRc9260m9vwscZiB0hiqsWavDH8eq0lzu8
         JyJAnFOcH3EhU6coT2h+cD+aNJhxrytqKnPSegEAfvt1iFKFoOBIotrwEDQ7+sh+Qw2z
         TN9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCrGUKl525zmUEGQyHM+B/2vcpZk3OR75Hf91sfqLSXbtkHYV1lfWhysY1Vin/J3OzVzysF7+ebU4Q4H7XQmWWgmgnoqWZeWZ70Xl4
X-Gm-Message-State: AOJu0Yx63YvTCMf2Oml2/TG+wXPpf+gTdudrrGOqzdV6Lw3Kx039J7LX
	6mom7wgPbyQuGmQd5RWaQlfZA6MrbWysW28v5GAQQdIOJ9Zbfoa1T0y0EHmEm3jmNJOwcPxfGdd
	zzDQn7335QejSzaYL7VnllJyK3ArBMLIWVjF3yyv7frIyNti8ZLuDbR0fq+g4Hg==
X-Received: by 2002:a05:6602:6411:b0:7e1:7a0b:309e with SMTP id ca18e2360f4ac-7eb571d8a89mr308503939f.4.1717763276384;
        Fri, 07 Jun 2024 05:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgIRlC0cojMP2aKUvU9Fr7ZztffoFIYMR/czaqcAI94Cnx2B/sfklXmqiLidBDJ3FGj6JBqw==
X-Received: by 2002:a05:6602:6411:b0:7e1:7a0b:309e with SMTP id ca18e2360f4ac-7eb571d8a89mr308500239f.4.1717763275781;
        Fri, 07 Jun 2024 05:27:55 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a225cecfsm829578173.64.2024.06.07.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:27:55 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:22 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <qe3bdssg2zw4r4rzwhdiklcrp24on4r66f2og5brkhulguph2t@jrjrpldght65>
References: <20240523050451.788754-1-coxu@redhat.com>
 <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>

Hi Baoquan,

On Fri, Jun 07, 2024 at 06:06:18PM +0800, Baoquan He wrote:
>Hi Coiby,
>
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption. Many users choose LUKS
>> and in some use cases like Confidential VM it's mandated. With kdump
>> enabled, when the 1st kernel crashes, the system could boot into the
>> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>> specified target. Currently, when dumping vmcore to a LUKS
>> encrypted device, there are two problems,
>
>I am done with this round of reviewing. The overall approach looks good
>to me, while there are places to improve or fix. I have added comment on
>all things I am concerned about, please check. Thanks for the effort.

Thanks for taking time on thoroughly reviewing the patches and
suggesting various improvements! I believe all comments have been
addressed now except for testing sme/tdx:)

>
>By the way, do you get confirmation on the solution from encryption/keys
>developer of redhat internally or upstream? With my understanding, it
>looks good. It may need their confirmation or approval in some ways.

Yes, actually cryptsetup's maintainer Milan pointed me to
libcryptsetup's new API and suggested me to reach out to Ondrej for
help. And Ondrej has already finished the major work in upstream
cryptsetup and systemd. But it will be good for them to have further
confirmation and I'll ask for their help. Thanks for the reminder!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


