Return-Path: <linux-kernel+bounces-353574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D08992FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719EC1C22CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E481D5ADE;
	Mon,  7 Oct 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcCwN+zg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FA18BBA3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312155; cv=none; b=ETahjMajMlF6sv8LV0RBhZ9ID81IbMqMNnwaDbb55OeByqh6cS1biiBR1vNeRRoZbrrQZDfUO+IxTFgnA0ahs1c0RXJnyC7DFYton4h4NkjoiLgUyOGgukWb0p5aeYeJdwJ2GaPETDQGeEA7aq7LPHltaV7ekAsygrlWyuFYkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312155; c=relaxed/simple;
	bh=D5kVbpKzUhQvMtWTZRZg9zhd9Je1CQMs6r/pautCquw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=kVT0l9Nqdu9gTMc8+O8gxQwq8UTP26GT3UjCh4eXXczno6a90YdTYSnM5ScS+Pn5oB9uWzfKytAPVH8gAlZ7SOPNVF7tw+sh70kwec2rV7sD5s3mkDS/aQtDJBgTitpzXRwxxmccxJ/6y6R2v7gXb5d2a1itc/L3pYmjg6Iq6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcCwN+zg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53991d05416so5264009e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312152; x=1728916952; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OG0U1jbBXC/7HilBWvE9sxBBHqzXaiJZGz0KVtp1OY=;
        b=JcCwN+zgmM1vTcUOlJNMEYM0jMe5Y9uz4lfKNna7L6JxjZv6dj+fFbJ7S4Mz21l2MC
         WPFZdEQgvgzvMxw27vRakqY7EmXAgJygO/9CWS0DM4Plw3CUA8IxXDoIjTsk2gsZtZti
         V+zj+Sj5BmafvNEhr+Q6mcBsbRQhqp9pt9ZneaS/r/1pnyFYT2fVdui9bbaoFrcrd7H/
         EJB3mQyPD1Zi93JIwikl8zuA8oTefkAB9QvCKyfmB++NE61hs5yVK6omFt6iNdNZ1E3V
         fgDTN5kykqfbQVRZC7rIvf6yE/0dQs1/k0WLpdiUxPSSkgc9YDVGC9SiaEHf+udebF3f
         mIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312152; x=1728916952;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5OG0U1jbBXC/7HilBWvE9sxBBHqzXaiJZGz0KVtp1OY=;
        b=C2uKs0KA+ORPFEHPDaEcgLJ9uKoIZrFLFMpZbq1ec7qKrdnc+xwkT/r3Qlb9LcxfXS
         vLSreY7N2hro/i61NMEX6f0S+dhuSQZTgTyfeW0YwbEfBQfC9qKn/AFmWgAdA6AMYTty
         SIkkrQ/bCeDYZXpNKaRUOVuksR7KMQUnfU2rFAWJdqXsWH+gBkm0iACNIHlzeXD52bm1
         RnzDEVNSWV5YXua/6JngF44TQc7fD4gq2pKYYzz4nReEuTUIT7ye+k+NzsrZ1P7L95sZ
         dQ7WB1/yhF8mM8kWJxK7rPY50y9kCeoRz2HBNJhHscT7oiTCWL6yKWgX0TR7oDOzLDoN
         tlNg==
X-Forwarded-Encrypted: i=1; AJvYcCUSLFbO8oRpIw+6MAP/Oa+KMq6uZCa9p903KYgToV/zFDjvNbzt3mLDPFMxt0kifOBDmJwDNAZISubt9OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGKVN7AyyzLCuAenNypHrcpSrfpZFIWGEaRvS3FTAKCsPdNud
	+pOix5GzJDtFK0U+HrOS9+pVNOK+2YL4RwnKOiX2VP4AZWPDvxkl
X-Google-Smtp-Source: AGHT+IGztI27Tmigl5KSZUpChAclReVjTvDqzmCe6NGfCs6+JNfloCcqixsHuiDwKgpyiigf26s/Rw==
X-Received: by 2002:a05:6512:138d:b0:533:4497:9f29 with SMTP id 2adb3069b0e04-539ab87dd29mr7436136e87.31.1728312151890;
        Mon, 07 Oct 2024 07:42:31 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9949a37f79sm240442766b.44.2024.10.07.07.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:42:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------DOSrrXCulbNPxmqX14qrO8oc"
Message-ID: <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
Date: Mon, 7 Oct 2024 16:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jgg@nvidia.com, kevin.tian@intel.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20241007041353.4756-3-suravee.suthikulpanit@amd.com>

This is a multi-part message in MIME format.
--------------DOSrrXCulbNPxmqX14qrO8oc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7. 10. 24 06:13, Suravee Suthikulpanit wrote:

> +
>   /****************************************************************************
>    *
>    * Helper functions
>    *
>    ****************************************************************************/
>   
> +static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	do {
> +		old.data128[1] = ptr->data128[1];
> +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
> +		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
> +	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));

Please note that try_cmpxchg inherently updates &old.data128[1] above on 
failure. There is no need to update value again in the loop.

Please also note that the value from ptr->data128[1] should be read 
using READ_ONCE() to prevent compiler from merging, refetching or 
reordering the read. Currently, there is no READ_ONCE() implemented for 
__int128, so something like the attached patch should be used.

Based on the above, the loop should be rewritten as:

	old.data128[1] = READ_ONCE(ptr->data128[1]);
	do {
		new->data[2] &= ~DTE_DATA2_INTR_MASK;
		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], 
new->data128[1]));

> +}
> +
> +static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
> +{
> +	struct dev_table_entry old = {};
> +
> +	/*
> +	 * Need to preserve DTE[96:106], which can be set by information in IVRS table.
> +	 * See set_dev_entry_from_acpi().
> +	 */
> +	new->data[1] |= ptr->data[1] & DTE_FLAG_MASK;
> +
> +	do {
> +		old.data128[0] = ptr->data128[0];
> +	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));

And this one as:

	old.data128[0] = READ_ONCE(ptr->data128[0]);
	do {
	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], 
new->data128[0]));

Best regards,
Uros.
--------------DOSrrXCulbNPxmqX14qrO8oc
Content-Type: text/plain; charset=UTF-8; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvcndvbmNlLmggYi9pbmNsdWRlL2Fz
bS1nZW5lcmljL3J3b25jZS5oCmluZGV4IDhkMGE2MjgwZTk4Mi4uOGJmOTQyYWQ1ZWYzIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL3J3b25jZS5oCisrKyBiL2luY2x1ZGUv
YXNtLWdlbmVyaWMvcndvbmNlLmgKQEAgLTMzLDcgKzMzLDcgQEAKICAqIChlLmcuIGEgdmly
dHVhbCBhZGRyZXNzKSBhbmQgYSBzdHJvbmcgcHJldmFpbGluZyB3aW5kLgogICovCiAjZGVm
aW5lIGNvbXBpbGV0aW1lX2Fzc2VydF9yd29uY2VfdHlwZSh0KQkJCQkJXAotCWNvbXBpbGV0
aW1lX2Fzc2VydChfX25hdGl2ZV93b3JkKHQpIHx8IHNpemVvZih0KSA9PSBzaXplb2YobG9u
ZyBsb25nKSwJXAorCWNvbXBpbGV0aW1lX2Fzc2VydChfX25hdGl2ZV93b3JkKHQpIHx8IHNp
emVvZih0KSA9PSBzaXplb2YoX19kd29yZF90eXBlKSwgXAogCQkiVW5zdXBwb3J0ZWQgYWNj
ZXNzIHNpemUgZm9yIHtSRUFELFdSSVRFfV9PTkNFKCkuIikKIAogLyoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvY29tcGls
ZXJfdHlwZXMuaAppbmRleCA5NGI4ZmVkZmIwNzcuLjg2MTVlOTFmNDhmZCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oCisrKyBiL2luY2x1ZGUvbGludXgv
Y29tcGlsZXJfdHlwZXMuaApAQCAtNDY5LDYgKzQ2OSwxMiBAQCBzdHJ1Y3QgZnRyYWNlX2xp
a2VseV9kYXRhIHsKIAkJdW5zaWduZWQgdHlwZToJKHVuc2lnbmVkIHR5cGUpMCwJCQlcCiAJ
CXNpZ25lZCB0eXBlOgkoc2lnbmVkIHR5cGUpMAogCisjaWZkZWYgX19TSVpFT0ZfSU5UMTI4
X18KKyNkZWZpbmUgX19kd29yZF90eXBlIF9faW50MTI4CisjZWxzZQorI2RlZmluZSBfX2R3
b3JkX3R5cGUgbG9uZyBsb25nCisjZW5kaWYKKwogI2RlZmluZSBfX3VucXVhbF9zY2FsYXJf
dHlwZW9mKHgpIHR5cGVvZigJCQkJXAogCQlfR2VuZXJpYygoeCksCQkJCQkJXAogCQkJIGNo
YXI6CShjaGFyKTAsCQkJCVwKQEAgLTQ3Niw3ICs0ODIsNyBAQCBzdHJ1Y3QgZnRyYWNlX2xp
a2VseV9kYXRhIHsKIAkJCSBfX3NjYWxhcl90eXBlX3RvX2V4cHJfY2FzZXMoc2hvcnQpLAkJ
XAogCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhpbnQpLAkJXAogCQkJIF9fc2Nh
bGFyX3R5cGVfdG9fZXhwcl9jYXNlcyhsb25nKSwJCVwKLQkJCSBfX3NjYWxhcl90eXBlX3Rv
X2V4cHJfY2FzZXMobG9uZyBsb25nKSwJXAorCQkJIF9fc2NhbGFyX3R5cGVfdG9fZXhwcl9j
YXNlcyhfX2R3b3JkX3R5cGUpLAlcCiAJCQkgZGVmYXVsdDogKHgpKSkKIAogLyogSXMgdGhp
cyB0eXBlIGEgbmF0aXZlIHdvcmQgc2l6ZSAtLSB1c2VmdWwgZm9yIGF0b21pYyBvcGVyYXRp
b25zICovCg==

--------------DOSrrXCulbNPxmqX14qrO8oc--

