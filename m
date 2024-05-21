Return-Path: <linux-kernel+bounces-184356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45B8CA607
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418471F2146F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70738D51D;
	Tue, 21 May 2024 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTswUnPi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A681E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256852; cv=none; b=IIVm/dBt+ZFOVN7VOfiHzc5bvD6XSfPNd7dEcSk6NmP+xCS0nv5o76oxv6zKeadrzrAHKyZ8p29a+/ur/0N7XDwQm33ZMvwgN1RiIZT8O7zu8Me9ySQs6L3t1fnhK2ytSKP0Ba/DHIoDfIqke40IPa6wZ3Gz6GfZmvvHE5ri8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256852; c=relaxed/simple;
	bh=LEe8CaSmZOU+/uH6TFaHHAqDZVuU4bc8AcBiyab2VOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/TljI7H9wZvhlOq/LwRSCBsYsg/0xV+n5KivtY7xv2w271AvPzjJdWUCQxImsjp17XoOGZSnfJjishWAO2AwxtRikCM06aZmgGA9MvL+SROuBVEWU/fd7sR5f1rwm1Oz971c+wAneFDmhq3v1ShoX5ZMJn1pvZVaHQTeWdBsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTswUnPi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716256849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5UjzgLZqQ1A3A/STroNQKIAanlssx47OVX19tlPyfkk=;
	b=GTswUnPiD0BvMqWkDscfajb6KPX+6OmmwRRvd7MRs5z3We7lP/MouP1Id49tOdMcgHVhR6
	kqA4x2VpuIifeGqobPYNH+p0jL1uEzMirL07gsfxBbTFxAKOvTCSHgRS5/DeBYgl4c3fci
	EftXDp8VQhr/bLiFyrDae2SNEqNt7Tg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-0Vr78hk1Ml23CrnB0BzL6Q-1; Mon, 20 May 2024 22:00:48 -0400
X-MC-Unique: 0Vr78hk1Ml23CrnB0BzL6Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f446a1ec59so11027934b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716256847; x=1716861647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UjzgLZqQ1A3A/STroNQKIAanlssx47OVX19tlPyfkk=;
        b=XhjTXpMnVkt5SXeOk63cynA4Mv/2JuwfW+bjWyByB47mON+0rBcuaXZuzLQtH+PXPi
         WzbQLwtTCDaoijKtHxxh83D5oLA9R6QbknOH0WIy59t+P65I6ARYtfQT8RBjIhDcHrrx
         Nl3zKk5Dia/RtAi9YYSs+aQW7vzGLv2aKTegQnNAEbqw8vlrg92X4UAUzntlKejPC6jU
         P1Krb2Q5B4VyWbh7XBGmXSW3Dz+dXvllY34rl0Pa1HjC+B+H/M5/M3jsvRjOoGBgHaL8
         darvUOFjQedJDSN907wwiGljDeVBwtk4bZ2cRm8/RQvqJzVfircGK46s/8+8SFuHGK5b
         PD+A==
X-Forwarded-Encrypted: i=1; AJvYcCUDsWjDrG5S/EsNWborODqD+QDvg5ZihaT0QAHNHCmInXW3hZPJyq6jFvcVSGlWFl3+xriB+uW5mG0lIKRmKvOW9l2JIy3+j6EESZif
X-Gm-Message-State: AOJu0Yw9n+L0Yy1UgecX3DWJ+seqw3G2gFFGvDpBicA0fx6eNO1B65qG
	RDGBKsxEn0v8ZVjvzBggN5+58CJupQX+jYKSdgVVmyNkrNHQ42MSuhuWBRjFNp3EzE243sdUPmT
	GtftBNl4QMV5/beduCG6EGfU9QiYADxLAB/vc0dRbJAGQe0ZmfKRFpiYWkuYLgA==
X-Received: by 2002:a05:6a00:c93:b0:6f3:ea4b:d235 with SMTP id d2e1a72fcca58-6f4e01b91eamr37168624b3a.0.1716256846918;
        Mon, 20 May 2024 19:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7HhBHnJNneyIw7ihYF0Kt+meuvDu1Ef/rXN+B35MEGXdllcXI7mvKKuXqDyPl0gxaXLFSQ==
X-Received: by 2002:a05:6a00:c93:b0:6f3:ea4b:d235 with SMTP id d2e1a72fcca58-6f4e01b91eamr37168566b3a.0.1716256846045;
        Mon, 20 May 2024 19:00:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f67f3sm19982062a12.62.2024.05.20.19.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 19:00:45 -0700 (PDT)
Date: Tue, 21 May 2024 09:58:36 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>

On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
>On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>
>Do you want to randomize the key's position for both kdump and kexec
>rebooting? Assume you only want to do that for kdump. If so, we may need
>to make that more specific in code.

Thanks for the suggestion! Currently, no one has requested this feature
for kexec reboot so yes, I only have kdump in mind. But kdump depends
on kexec thus I'm not sure how we can make it kdump specfic. Do you have
a further suggestion?


>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>index 060835bb82d5..fc1e20d565d5 100644
>--- a/include/linux/kexec.h
>+++ b/include/linux/kexec.h
>@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>  * @buf_min:	The buffer can't be placed below this address.
>  * @buf_max:	The buffer can't be placed above this address.
>  * @top_down:	Allocate from top of memory.
>+ * @random:	Place the buffer at a random position.

How about a comment here saying this is currently only used by kdump.

-- 
Best regards,
Coiby


