Return-Path: <linux-kernel+bounces-370771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9629A31DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEA91C20328
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C13B192;
	Fri, 18 Oct 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLnyqgF+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4002A1CA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213528; cv=none; b=pF7shQOLhqD6d0emMIBTs719J8X4a/nP3QA3nWSeHlS0mwSr9+5xFPC+ZLW9dHJKiltmxMy5agjqPe2AGTO27QUv7S1bmOv0hYh/efXA2MsQTCosj7ZO0BDQzO/cdJNouYeuir8cdOWPK7AUQ4tBppKH6l+HI8dlRbx+F1BFQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213528; c=relaxed/simple;
	bh=kowSXiXyruiDJjF7LO4J2w2r2fb4k0BptEpNJwqyAk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb0A1wQ8S7Bee4UI2OjJxYLtO1fPDmg3FfFzySRLM9Ih2bm9cIMl0IxxlClyXWZ15jPGcBO6pORmcOtFahBldvoBdWTjLGdlE0Z5q3A+k9fC3jLR9lhbS3EkXzSzpf6MFrO57/XiiJv3A6Woh4OedJGl8ye2U2Qq+DOa1Yg8MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLnyqgF+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729213524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
	b=RLnyqgF+44tDfKJq5+ety95O0gjWyEJY4I7/6d3jIW80y+Ekl55jA+n5XTDqTXA5Anamk3
	8UrXYtae4xt4mI1Z6I7qVVKyOiDxhtWN8BXCr9FdDePpCsapflUp7wEsH0CyBOuk7VOvpa
	njyWuJQtckz5YHFjtl6/LwAdyk/pBUM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-S7_DFpjrMNW4Prtng1TWjg-1; Thu, 17 Oct 2024 21:05:23 -0400
X-MC-Unique: S7_DFpjrMNW4Prtng1TWjg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20c7ea6b060so17864905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213522; x=1729818322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
        b=Htm5NZunRjcSoWohTSy0Mn8A6xQs5+huV0jUsHAMSFs2/9PscJ0ZgUEsd1s5B/aWQP
         BHsurZk2uz206bRL1vhrl5He6SsKt+dfxkw2NZO4JQB113bXF0WhyNA3mnzD4zKHIe8D
         +0DbJvffPgY1zdzIVbQhzPzniJWHB4Y7oO6B/t4mRzhWGXkvaxjn2sQHlnfdcznpxFNZ
         nxXMMXs9u2vs+6Ky83IxD7xMpCTZRbKsmc8/L7uEbeluSkuXNz5VRL6H+5K938iLseB3
         couxLFGDN+hdSXjNy2XLqV4TAsBiMf79JZcMhVR+RlJflc975+5SwfElPCwn6ibryUfW
         trSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0YhtQCoiq4OSM3eToXgOq4kVe92FTsNDG7hpJaFKL/3Kh0pNLrs1MWXz18YZ/HHFPOH2RCfITTN+/TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQbuvi44fCpOePKzuICWq/8a7Be7wHeMxzmSN4RQ5uanxCXrK
	4yDmmhG3SAX24pN8Fu4pIdsJizhdZhU2UnwfZEczPy5oUMfr6LedraHn8FFJqFLX/DaW4S7G8k7
	xD1kvOH/oUcGc3JE4vG+7plV5oPvEvvDGgqokhZ2PhktKYiKsmVkkclhGQ9WzZA==
X-Received: by 2002:a17:903:27c4:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-20e5a90621dmr9397845ad.38.1729213522193;
        Thu, 17 Oct 2024 18:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDlBlNRTAwPlOe5LtFgMxaSDqQm867MYlk0mBbHAqo4GOqATrNJ9lNsl2cgC6uZOG0DEq5kA==
X-Received: by 2002:a17:903:27c4:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-20e5a90621dmr9397575ad.38.1729213521804;
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a753378sm2444375ad.98.2024.10.17.18.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:02:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <wxsunpjqmro2ouupfvhkoc744jvfdx3g3fmg5zec6ouuibsnt5@ncdx66ndiaz2>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
 <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
 <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>

On Mon, Jun 10, 2024 at 09:18:53AM +0800, Baoquan He wrote:
>On 06/07/24 at 08:27pm, Coiby Xu wrote:
>> On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> > .....
>> > > diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> > > new file mode 100644
>> > > index 000000000000..78809189084a
>> > > --- /dev/null
>> > > +++ b/kernel/crash_dump_dm_crypt.c
>> > > @@ -0,0 +1,113 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> [...]
>> > > +
>> > > +static unsigned int key_count;
>> > > +static size_t keys_header_size;
>> >
>> > These two global variables seems not so necessary. Please see comment at
>> > below.
>>
>> Thanks for the comment! But I think it's better to keep these two static
>> variables for reasons as will be explained later.
>>
>> >
>> > > +
>> > > +struct dm_crypt_key {
>> > > +	unsigned int key_size;
>> > > +	char key_desc[KEY_DESC_LEN];
>> > > +	u8 data[KEY_SIZE_MAX];
>> > > +};
>> > > +
>> > > +static struct keys_header {
>> > > +	unsigned int key_count;
>> >                     ~~~~~~~~
>> >                     This is the max number a system have from init();
>> > You can add one field member to record how many key slots have been
>> > used.
>> > > +	struct dm_crypt_key keys[] __counted_by(key_count);
>> > > +} *keys_header;
>> >
>> > Maybe we can rearrange the keys_header like below, the name may not be
>> > very appropriate though.
>> >
>> > static struct keys_header {
>> > 	unsigned int max_key_slots;
>> > 	unsigned int used_key_slots;
>> > 	struct dm_crypt_key keys[] __counted_by(key_count);
>> > } *keys_header;
>>
>> Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
>> maximum number of dm crypt keys 2) we only need to let the kdump kernel
>> now how many keys are saved, so I simply use total_keys instead of
>> key_count in struct keys_header in v5,
>>
>> static struct keys_header {
>> 	unsigned int total_keys;
>> 	struct dm_crypt_key keys[] __counted_by(total_keys);
>> } *keys_header;
>>
>> Hopefully this renaming will improve code readability.
>
>If you add key_count into keys_header, then kdump kernel will know how
>many keys are really saved and need be retrieved. What's your concern
>when you have to put key_count outside and take it as a global variable?

Yes, the kdump kernel can know how many keys by reading keys_header. But
1st kernel needs to know how many keys are recorded so far as user space
is expected to tell the kernel which keys are needed one by one and the
key_count will be increased witch each new key.

>
>>
>> >
>> > >
>> >
>> > > +
>> > > +static size_t get_keys_header_size(struct keys_header *keys_header,
>> > > +				   size_t key_count)
>> > > +{
>> > > +	return struct_size(keys_header, keys, key_count);
>> > > +}
>> >
>> > I personally don't think get_keys_header_size is so necessary. If we
>> > have to keep it, may be we can remove the global variable
>> > keys_header_size, we can call get_keys_header_size() and use local
>> > variable to record the value instead.
>>
>> Thanks for the suggestion! But the kdump kernel also need to call
>> get_keys_header_size in later patches.
>
>If so, you can remove keys_header_size now. You can define local
>variable to take the newly calculated value. keys_header_size seems not
>so necesary.

Sure, new version will have the global variable keys_header_size
removed which can make the code a bit easier to reason about, thanks!

>
>By the way, you don't need to rush to post v5. When people review
>patches, agreement need be reached after discussion. Then next version
>can be posted.

Thanks for the suggestion! I'll wait for the consensus to be truly
reached next time.

And sorry, it takes longer time than I have expected to evaluate all the
feedback. In retrospective, maybe it's better to respond to each
feedback in a parallel manner than pondering over all the feedback
first.

-- 
Best regards,
Coiby


