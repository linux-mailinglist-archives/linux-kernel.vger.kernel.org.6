Return-Path: <linux-kernel+bounces-418007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA29D5BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD78B1F236B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987701D7E35;
	Fri, 22 Nov 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu0ZAtnY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1391D7996
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267020; cv=none; b=eW515cmD8veNJ+Kyq6JlqCi9fDD9BLHDfmDLR/qVpaDCRUaT3Q2DeX1zValZB6+rWu2g+SUx4SC3b/x5ZyJesvtgXDfa+FnivT6QjYL1r9I1VKQYYkvb/4IuO2jQ4M3KpDDga42cniuqQz88+ZZM4+Hfpp+fBnRrQcpDSZmLuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267020; c=relaxed/simple;
	bh=pfDeka+wDs610l+yfP6uYMmifgUfnr/ZLDWOPuzEEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZF5QhtDwfcwlsmSOOVbda82XagBcDl5ue/xWPcNb/70cw8QQFqpYuh8Q4McI9+CCnscegkzwqOqTsBoZIbFJxqaNHw6uzTzTMleihKT93tsghB6MeqDqIBdHH/9Knw+rpypCBgUdTa+zUlefy8O031QVDXzpJGP06irfPgWesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu0ZAtnY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTleGtvdq1osypVXWqisdoYoTofXyVXhiRbJdgp9AcQ=;
	b=Bu0ZAtnYOXJRIvnQwAUvztvuGgDnzohIWetOjhNrjXEsOT19YRj0p9qnQ8u3CSudxIYQ+c
	tsG5yJ8lU+2eS+pasxfC1K5D9tN80pk3d3MleG4kja5Fj5/mCoy94ubyaeY+fdQ0FV/QcH
	Z/ifaOPYSCZrN+rsdZbHZE4NCQSjlRM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-yqNZKyvGM92oYIoNe2PX8A-1; Fri,
 22 Nov 2024 04:16:55 -0500
X-MC-Unique: yqNZKyvGM92oYIoNe2PX8A-1
X-Mimecast-MFC-AGG-ID: yqNZKyvGM92oYIoNe2PX8A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23FF01955BF4;
	Fri, 22 Nov 2024 09:16:52 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E86D01955E9E;
	Fri, 22 Nov 2024 09:16:49 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:16:45 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
Message-ID: <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-4-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
......snip...
> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  	}
>  
> +	/* We'll recheck under lock later. */
> +	if (data_race(vmcore_opened))
> +		return -EBUSY;

As I commented to patch 7, if vmcore is opened and closed after
checking, do we need to give up any chance to add device dumping
as below? 

fd = open(/proc/vmcore);
...do checking;
close(fd);

quit any device dump adding;

run makedumpfile on s390;
  ->fd = open(/proc/vmcore);
    -> try to dump;
  ->close(fd);

> +
>  	if (!data || !strlen(data->dump_name) ||
>  	    !data->vmcoredd_callback || !data->size)
>  		return -EINVAL;
> @@ -1515,12 +1507,16 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->buf = buf;
>  	dump->size = data_size;
>  
> -	/* Add the dump to driver sysfs list */
> +	/* Add the dump to driver sysfs list and update the elfcore hdr */
>  	mutex_lock(&vmcore_mutex);
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	mutex_unlock(&vmcore_mutex);
> +	if (vmcore_opened) {
> +		ret = -EBUSY;
> +		goto out_err;
> +	}
>  
> +	list_add_tail(&dump->list, &vmcoredd_list);
>  	vmcoredd_update_size(data_size);
> +	mutex_unlock(&vmcore_mutex);
>  	return 0;
>  
>  out_err:
> -- 
> 2.46.1
> 


