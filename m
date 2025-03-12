Return-Path: <linux-kernel+bounces-558094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09FA5E197
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3BB1894FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD600155A4E;
	Wed, 12 Mar 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pMR6sWbP"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32B1C57B2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796094; cv=none; b=efdXpwE/+0nnx781bMwWCiJ5Yu1zX78Gmh31Itr/9fbJGXc9CnuWbVTP1QHAjckBk/GfxIJe4+WipiJcyrSLw6zb4/Iz4xdL+FSLlvl73qdKBw6TSohaa4mAqeNufNzHl1f9TAhYi6Il3ZRyCcvz2irzcsta5PbZfFD4tIaj82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796094; c=relaxed/simple;
	bh=zQrBWGYwZurbz8XMiTIkddhXWxU662twgtsGFLH4czw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr6/7HlbVAgja0idILn1u9pmWlWeg7FE/I1ib1L8boHwVkd2NZdGiujVlqo+sOZzhAyIXqIIeM9neLedy4RhqtYnvx18gmi/oBwSohXnvmC+74Ayg1gvLunnnPjJNpKhPmUqJd5PzsW3kqyFfsYonfevDcXBpwAtvIsauX9xBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pMR6sWbP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08b14baa9so621016485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741796091; x=1742400891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIjT65nGfepzfzKoi41aW6eYKNFsxtk8vKr2eFrJrrM=;
        b=pMR6sWbPfujBsAe3o8YCzCuCNyls1YSLqHcDMDQM5xHliBTE6cA0kPwN0J+b/WPJzm
         cTE4oSy+cVqoeNw4bGq49ntijOLXKaI9C5PwcK705GGyNVv+hUOpmjCPEyk+DazCb6ef
         IwNpf8CDWhBfs966C/Wg+vTmD6SAwON7U1nR+slTzM/q0PN1aPSnnOFraZh0M8x7v1rU
         Dk3VbqDdhayCyBua4lnVCNtcMg35C4uhpQlN/irMzAOV6x0wXeY6h8uuXR2iB+G9XzOh
         5srtyILqlXCLYXwyZa9wHBhpN5t/O+K38g8djNHvNL4gclTDeKoiAdcZDWpSTezdQiG/
         jTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796091; x=1742400891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIjT65nGfepzfzKoi41aW6eYKNFsxtk8vKr2eFrJrrM=;
        b=bpyT+Bthl/spjOSGx1tdYslmy9LFQoXvS5a3EvRrNK5YEey1W93qiU1BP5L+VLH+Mj
         6rNABN1Wxwthg8ZebT6pXXmozjGqMsPNcfyKUYa/XkLzYYrjP7b04bNWzhjmirvLcLoR
         qO0j7N0kILYlBdiNpgXYDA+kCj2W6OGnCNK6f37K95q5y0yheTV0JnAgN77lzi5QcUtV
         07QBzw4CUaJ5Jyhjo1lYZz0cZXjSLUJGiJd77eFf9DgKKIP4sZbAwGXfujDDmStZDnTP
         WqZVA0KPqazrRyciMNIzgA71vPAaztaB8hyAhz9CBCUW/qHM/+RUr53eNHlhxuHQVLyd
         Kopg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkP/TK7u0B9puxB1o0Eu1VlyvIBI/JEzSwYiY+xBbVHT+R48UIJS2JnGCfu52bUghFCXI/qo6I5LEKms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdyV7eGvY6oIKzgi+10FS3liiM/HjYnf7u+zV8TpooUMHj95q
	3J4ulDcQkfImO0zYpMLfEj+oW539gRMECamJgqch7K95a/QQozQI+HgqMjuEPlo=
X-Gm-Gg: ASbGncsGgEG61XSv2M5A5WU6ntqLg8NQq4SDwJog8QPNmALeLMBdRa1kHwbBdOolIIs
	CS++hES+RYEQVtQaj0EBjBnCS57rbKUwcd4il6KNtt0NBi6qf0hjOlOYBuA5ZFA7cgQz1YruVGu
	18RnkYc/0HmNozmJfJBtLvZFQxSvj7oIYpvExHqh7puEO2yvKumFVxvtk1OQujStaeiw6xMd1u4
	BRNp0UOS56qS0dozodX//D1v36KMGJzp5kciMm1Nkip4JGMSFaZA0ZUJsjkcPfy7IXRmwaJrewX
	gu8VtCJjmbjhOaldOkLcAYC1O1VNM9bcegnxT6FXBUS6B1y4AO1G3AbqagSJMK7teDmS1U0qOCJ
	iYUi6am49vjZcBHuCt1zNy4zaAPQ=
X-Google-Smtp-Source: AGHT+IG+8rERSwdLPDmJ7q5S5rs/MpxcJmuKt121pRGZODlzzovdTpsRc1C244/5Pj4nPgKibBScWQ==
X-Received: by 2002:a05:620a:439a:b0:7c5:5e05:df2d with SMTP id af79cd13be357-7c55e05e0e5mr1268460785a.29.1741796090969;
        Wed, 12 Mar 2025 09:14:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c45e28c86asm890301385a.16.2025.03.12.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:14:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:14:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory
 hotplug in weighted interleave
Message-ID: <Z9Gy-No6pXFWZAyc@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
 <20250312075628.648-3-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-3-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:26PM +0900, Rakie Kim wrote:
> Previously, sysfs entries for weighted interleave were only created during
> initialization, preventing dynamically added memory nodes from being recognized.
> 
> This patch enables sysfs registration for nodes added via memory hotplug,
> allowing weighted interleave settings to be updated as the system memory
> configuration changes.
>

In patch 2 you said:

```
With this enhancement, the weighted interleave policy now properly supports
memory hotplug, ensuring that newly added nodes are recognized and sysfs
entries are created accordingly.
```

By description, this claims to accomplish functionally the same thing
patch 2 claim.

The code below actually does two things:

1) Refactors the sysfs code to break out the weighted_interleave group
   into a global that can be referenced by the hotplug callback.

2) The change the the memory hotplug callback to add/remove nodes.

Move the refactor work out ahead in a separate patch to make it easier
to review the changes individually please.

> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 78 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 94efff89e0be..71aff1276d4d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3389,6 +3389,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct iw_node_group {
> +	struct kobject *wi_kobj;
> +	struct iw_node_attr **nattrs;
> +};
> +
> +static struct iw_node_group *ngrp;
> +

for a global, this should have a more descriptive name.

And since this actually represents the weighted_interleave sysfs entry,
it should maybe be `sysfs_wi_group`?  Since it will include more than
just nodes (e.g. the upcoming `auto`)

>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3431,24 +3438,22 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_release(int nid)
>  {
> -	if (!node_attr)
> +	if (!ngrp->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(ngrp->wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
> +	kfree(ngrp->nattrs[nid]->kobj_attr.attr.name);
> +	kfree(ngrp->nattrs[nid]);
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
>  {
> -	int i;
> +	int nid;
>  
> -	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +	for (nid = 0; nid < nr_node_ids; nid++)
> +		sysfs_wi_node_release(nid);
>  	kobject_put(wi_kobj);
>  }
>  
> @@ -3457,7 +3462,7 @@ static const struct kobj_type wi_ktype = {
>  	.release = sysfs_wi_release,
>  };
>  
> -static int add_weight_node(int nid, struct kobject *wi_kobj)
> +static int sysfs_wi_node_add(int nid)
>  {
>  	struct iw_node_attr *node_attr;
>  	char *name;
> @@ -3479,19 +3484,17 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  	node_attr->kobj_attr.store = node_store;
>  	node_attr->nid = nid;
>  
> -	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
> +	if (sysfs_create_file(ngrp->wi_kobj, &node_attr->kobj_attr.attr)) {
>  		kfree(node_attr->kobj_attr.attr.name);
>  		kfree(node_attr);
>  		pr_err("failed to add attribute to weighted_interleave\n");
>  		return -ENOMEM;
>  	}
>  
> -	node_attrs[nid] = node_attr;
> +	ngrp->nattrs[nid] = node_attr;
>  	return 0;
>  }
>  
> -struct kobject *wi_kobj;
> -
>  static int wi_node_notifier(struct notifier_block *nb,
>  			       unsigned long action, void *data)
>  {
> @@ -3504,15 +3507,15 @@ static int wi_node_notifier(struct notifier_block *nb,
>  
>  	switch(action) {
>  	case MEM_ONLINE:
> -		err = add_weight_node(nid, wi_kobj);
> +		err = sysfs_wi_node_add(nid);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> -			kobject_put(wi_kobj);
> +			kobject_put(ngrp->wi_kobj);
>  			return NOTIFY_BAD;
>  		}
>  		break;
>  	case MEM_OFFLINE:
> -		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> +		sysfs_wi_node_release(nid);
>  		break;
>  	}
>  
> @@ -3524,14 +3527,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  {
>  	int nid, err;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	ngrp->wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!ngrp->wi_kobj)
>  		return -ENOMEM;
>  
> -	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> +	err = kobject_init_and_add(ngrp->wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");
>  	if (err) {
> -		kfree(wi_kobj);
> +		kfree(ngrp->wi_kobj);
>  		return err;
>  	}
>  
> @@ -3539,7 +3542,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  		if (!node_state(nid, N_MEMORY))
>  			continue;
>  
> -		err = add_weight_node(nid, wi_kobj);
> +		err = sysfs_wi_node_add(nid);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
>  			goto err_out;
> @@ -3550,7 +3553,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	return 0;
>  
>  err_out:
> -	kobject_put(wi_kobj);
> +	kobject_put(ngrp->wi_kobj);
>  	return err;
>  }
>  
> @@ -3565,7 +3568,9 @@ static void mempolicy_kobj_release(struct kobject *kobj)
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> -	kfree(node_attrs);
> +
> +	kfree(ngrp->nattrs);
> +	kfree(ngrp);
>  	kfree(kobj);
>  }
>  
> @@ -3578,17 +3583,23 @@ static int __init mempolicy_sysfs_init(void)
>  	int err;
>  	static struct kobject *mempolicy_kobj;
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> +	ngrp = kzalloc(sizeof(*ngrp), GFP_KERNEL);
> +	if (!ngrp) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
> +	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			       GFP_KERNEL);
> +	if (!ngrp->nattrs) {
> +		err = -ENOMEM;
> +		goto ngrp_out;
> +	}
> +
>  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
>  	if (!mempolicy_kobj) {
>  		err = -ENOMEM;
> -		goto node_out;
> +		goto nattr_out;
>  	}
>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> @@ -3606,12 +3617,13 @@ static int __init mempolicy_sysfs_init(void)
>  
>  	return 0;
>  
> -node_out:
> -	kfree(node_attrs);
> +nattr_out:
> +	kfree(ngrp->nattrs);
> +ngrp_out:
> +	kfree(ngrp);
>  err_out:
>  	pr_err("mempolicy sysfs structure failed to initialize\n");
>  	return err;
> -
>  }
>  
>  late_initcall(mempolicy_sysfs_init);
> -- 
> 2.34.1
> 

