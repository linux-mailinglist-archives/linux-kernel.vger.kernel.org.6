Return-Path: <linux-kernel+bounces-187009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C68CCBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D081C21712
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E63C13A878;
	Thu, 23 May 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZb6tY+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4642A87
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442523; cv=none; b=bQ4mZ6vJlqGnU5Tezky9DRJ1o6u7rZQbEvN2tkfU6m2oUHYe6vx3IvAGzZq+642n/4sGXqFXolTozIXllJuibv4Y8mCKcG+hAl/4cD6HO6aswQgeqr3Utl+GLeHUrwknTnY2ZaW8Gx9DshgEZ4kC1DUvsp8Igyh1Kn/ypERJjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442523; c=relaxed/simple;
	bh=9MSePypnN2x7tkFIRXGJk1Lfzb+uoHj4i2u0JdsvilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYGhLmoRWXzVFwZTvdu2VPqM5E7DDuUcqO9LuAVTYEaXYSmN0jsDwuVGeUv615Gl78YmVj2N2kOKElTthQzxE/Rav5KQeR2kV2IgIemBgOBQwu1XK52+18TYTKKCszB1K8nBTdmALtT41bwz72mxXM4TMPTJD8wEXsdCzXlQYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZb6tY+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716442520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
	b=ZZb6tY+7e9en80uM08iYl6kjXi6ZDzsUKAq5xLvd1mCG3fXm9XoSRlrAdZNdlRi9jj0gRe
	Ya5Leq1Fw3um8gmDIZY+ElrrP3qO/GyA1V4tQhNdCgyGCKbBdjhK4QTjohuKaBBKD3TSAI
	uSBeJXx6g1kxDJEKJ2nT1lrEYIZDmCg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-FfEMeLvpN8SK-ekGpe-uQg-1; Thu, 23 May 2024 01:35:19 -0400
X-MC-Unique: FfEMeLvpN8SK-ekGpe-uQg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c9a56ffb64so722157b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716442518; x=1717047318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
        b=rH8PetNkvoA/zQDH4mR5gK5WxnAhwRXz2Eth0mJfGeg4Ei7MlXNDNNvICpzPIGQDWh
         Te9YZyTkULKCaqe5w1HoKYUcjny4UUGxRBUZ6/w8sK35TV9YJT8+IO7XafNoQHZrmp/q
         3QTepbvUb3bkHO7Oogipit24g3j+IjAS6xSPhZPj8cdf9mm23oA/0YPt/4xz6qDFoGO8
         KvFbApjxAmMQCptpf2j3ZsZ6nRZCTEGqP/1yOh/iepwdDRa4uGrmIyKaP9AEdhCbYyLK
         tzsIJOYoxsMMfsMppCm4XvYPd4V6RAFRH9yjFtSVQ/MRR7BuR3OTVhmSaO9UAm93ZWQb
         DLmA==
X-Forwarded-Encrypted: i=1; AJvYcCVAd2jzZN6sRxJviZE4Y5Fjmw4uFnwxmqOOMETyavzMFnOAxI5BvE1l8PQkD9T/tLiLZq/9gJdFaq5Xf3ya2Gl29OdX2mCmomNp4R5z
X-Gm-Message-State: AOJu0Yy/Y9fNuw14hPtUjn+XkOSBFU4mmrscsK3dGyng4qC9Czv5Q2Us
	B6wf0+mbT2f2YssB0Oa7qYfLPLEU27oNJH6sIBnLiji1NMkeeyRWeNtXB7UtmGR63XzSpYZVkcU
	ikTERraSS6ppvoHshq1ARWVuttuzT38Z+M7QWJOmIV/z29skLGxsal7tsNUUmlg==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851750b6e.0.1716442517758;
        Wed, 22 May 2024 22:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9TCM4OePsLNJcyJGxLImpn1NPmzuyatA+WiPDO4CMkcIyNbE/3eCPkgw29C+PBMkQ6fM4w==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851705b6e.0.1716442516284;
        Wed, 22 May 2024 22:35:16 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm23300983b3a.186.2024.05.22.22.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:35:15 -0700 (PDT)
Date: Thu, 23 May 2024 13:34:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <xnsvk5wlfuxomr3aayz6essyzgofux5orj366cizh5525ygbbx@tpdunjmf53m7>
References: <20240425100434.198925-3-coxu@redhat.com>
 <202404262003.qsWvGwZU-lkp@intel.com>
 <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>

On Tue, May 21, 2024 at 11:20:35AM +0800, Baoquan He wrote:
>On 04/26/24 at 09:10pm, kernel test robot wrote:
>> Hi Coiby,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v6.9-rc5 next-20240426]
>> [cannot apply to tip/x86/core]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
>> base:   linus/master
>> patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
>> patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
>> config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
>> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)
>
>
>Please respond to the lkp report in time whether it's a problem or not,
>otherwise the link will be unavailable.

Thanks for the reminder! I've fixed the reported problem in v4.

>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>> >> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?

Yes, symbol 'keys_header' should be static! Thanks for the report!

>>
>> vim +/keys_header +31 kernel/crash_dump_dm_crypt.c
>>
>>     27	
>>     28	struct keys_header {
>>     29		unsigned int key_count;
>>     30		struct dm_crypt_key keys[] __counted_by(key_count);
>>   > 31	} *keys_header;
>>     32	
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>

-- 
Best regards,
Coiby


