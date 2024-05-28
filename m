Return-Path: <linux-kernel+bounces-192837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E276B8D22EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EDC1C22CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56B47F60;
	Tue, 28 May 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnSuDa3J"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC431A89;
	Tue, 28 May 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919301; cv=none; b=YcsBPBIo0H0TXeYhyDYuQSsEAjEg8+s0rsG4TatpnWYpgl6dzg9Bwn8ayawveRjIbB+F2WY8BR3tso0wboOqoRlon77NPuLfd/LNqljzxTRVyeAtPRrrcqpzcGyA982DTiVD+i8lhVosDWDH3HslA0i6+9ugBk26cceMB95IYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919301; c=relaxed/simple;
	bh=GCsCBkj4fvi/PkMdjWR0qYhZOtkq2Z5Qohz8EvhenNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae/zeNcizx64WNd5i+59XzYQFYQVWfB8vweOr+ZlMob05HsMvYeEs2Hgz5EEr4bbCndI8e8NWKXXDmHW3rg/0Neu6Nwzwoz3odsxNkVS7pIAZ+kQqNXTvnu/nOBfCVoPqWOG1zbD1lAZiFUEvOvpYl7kVG1Sb5pt+zWHETuatQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnSuDa3J; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-794ab20699cso79072685a.2;
        Tue, 28 May 2024 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716919299; x=1717524099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sONTQW+N8gItfOL0odDu1qGNxZ7K2PPzXhcFBElLPTM=;
        b=GnSuDa3JpCer8LYq938hzi+YVlMOBXsMwcH57Ou8xDEomT/RS5wjBF/Ae1sYfZe/Je
         iIw3n+tLOKmgtqCHCmtfdgDofAlSejdMGmvhBGv7315TJE0qXDgPAQf/2Q5agWJ7DAG/
         quk+F8FpWip8YSYZf+WboodzQd2Ywiqwme05td4up3Qjvp2U3PD5Q9641ZmpflhtYvai
         B7gUcHQlKPidYk+eVWQQ4XOVC6BgpDI/Cifqqyo7xCOaT4Xfx3MHuWo17j/2PWTsk5Jv
         8eLfS8oNPWfyjpXgQIIBVg+vsg9U6iOZq6D7du1SoR4WcyMt6mPdRWuc09wHQBS5ZUrK
         WgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919299; x=1717524099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sONTQW+N8gItfOL0odDu1qGNxZ7K2PPzXhcFBElLPTM=;
        b=Rk/rh6zNtamRenG3sRr0gD+R6fa/vkWW/HmYgljgl6lQ4s4OJEGsFAhD/sbdLWI0SW
         gdn8rKMzsTZXaJmxp+f3yJBTaUYAyKqMp2LoxIs3SlEiDmRXsQ2qIqMqgm56zvVLPCUP
         MqrhG/iMJYqQuRbDm+zPYbEyhSZD/ah9qYGorQMJI9ULn1hQmQXIibhP9ExTVAIEJuvn
         9d4E1nFDHg55noQDsgsTmAkUNJSGiVpowO/2eWKDJMlZjMoNnyx3uyjWjaOzLvWLfRnu
         dS1I6853Rm12YrteZI5enHK3KnpXjoMyZ82C3MeoFTcEwARhCorQ55flRy2dW6ECncX/
         lAHw==
X-Forwarded-Encrypted: i=1; AJvYcCVczsrTAyMXVlREEEuMS/jgKYLpmoiQeEyO/ofTA14szmeKNG9ZXebNk4tPLEULzzErYLqGOY8Yqo+YbIQxjJhEbwV2CyPvYB7Mij6PvL1WtM9YTozCnZy4KC9Khe4PNFa6Y5F9p0UiJqbp7wZz
X-Gm-Message-State: AOJu0YxqYdDZmo+R5RGDB0QIOvnF6s3eqBmBE1fqf/aLeeqWifO7Snvn
	83b1iRSIN1y61vDau5YONgD+VhTiRSPbRhgMzd8Y42EVCzTVe73pq+m3dA==
X-Google-Smtp-Source: AGHT+IGQoPnAGypwX43waSjSxqHn7PsPw4Fk92sfKXBSE0ozT5Yw0eJjYkPzDttzVwmE4RY9wGiJbw==
X-Received: by 2002:a05:620a:11ba:b0:792:9741:ca86 with SMTP id af79cd13be357-794ab057bbbmr1522417585a.11.1716919299251;
        Tue, 28 May 2024 11:01:39 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd32585sm399063285a.107.2024.05.28.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:01:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 977531200032;
	Tue, 28 May 2024 14:00:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 May 2024 14:00:58 -0400
X-ME-Sender: <xms:2htWZu9z4pDGButKbrS6FoI2Nsehrate_IXwMDHwogiAXMGPijdCYw>
    <xme:2htWZusy3o6o2T-edMk0tF7t2ZC8WReOUM36IuYfZuQfkzPPnj1Ow6bfv7yf4JPJI
    ddsSXaaMHJuUBnLJQ>
X-ME-Received: <xmr:2htWZkAoXyjY6zy0w6ZnKU-v9xcvD_LpxvF6lBSK9ncdKFarSLK-8243bl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:2htWZmcPkY5GU1VLzJNI_Bc2eXdnIe8Eg5SJq6uDnrdNNzos3gaB2Q>
    <xmx:2htWZjPd0cixqFRysOdOhvQFnYTiYEg6YOrhhxk3derYyhPIgW_5Lw>
    <xmx:2htWZgmdAbTQV4iHThJq4ByLvjssV0ikUOhPBFUlHTa7ocijhb36AQ>
    <xmx:2htWZluErxy0T7-s4GJqLUdesvb09R09SUMnjoL1wvMG61Ws-mzWlg>
    <xmx:2htWZpvpOd4oUy-yUhkchFx8lH0fw7cutEJ45XBNgQ1sO8u6RRexpwxn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 14:00:57 -0400 (EDT)
Date: Tue, 28 May 2024 11:00:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Message-ID: <ZlYbst1xppRKBxwm@boqun-archlinux>
References: <20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com>

On Fri, May 24, 2024 at 05:18:11PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  kernel/locking/test-ww_mutex.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..0fab96137ddb 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -695,5 +695,6 @@ static void __exit test_ww_mutex_exit(void)
>  module_init(test_ww_mutex_init);
>  module_exit(test_ww_mutex_exit);
>  
> +MODULE_DESCRIPTION("API test facility for ww_mutexes");


This looks good to me, but seems to me MODULE_DESCRIPTION() is usually
placed after MODULE_AUTHOR(), could you reorder it a bit? Thanks!

Regards,
Boqun

>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Intel Corporation");
> 
> ---
> base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
> change-id: 20240524-md-test-ww_mutex-c18c263bc483
> 

