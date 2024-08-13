Return-Path: <linux-kernel+bounces-284263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64A94FF17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C08DB220C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F378C6C;
	Tue, 13 Aug 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yehQpvde"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B418446B4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535499; cv=none; b=jB+N1al/5Jf6h/Zi6JdQf/zlb0j2GOMZ5j4XLosi1IULa+fMxPhOYQl0/vB5d1bN3Yz34QPVsRN8mfzsCXKnhGUIOncMhPm/8X1rjUEOLGWSZ7dhvlJthAZ9j5fpgUi8t8qPz38+VhmDawjgq5+Ov4qTj03k1hJ4Oik5QDsNLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535499; c=relaxed/simple;
	bh=TQs3UM+FSjGVU9U4BLoHR1rKdtRKTH0zkbjIiuLXMlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUivRwR4ygXhfsjKSsChCKZYdcgFL9+Ok+URqewTpRJkGVyXe14q1lq4Xm2MXtVE12OLmaJNabY4cgcbWqOB7yQIbbwCwKzZiASAjIzyxj5T02dqbyZI3X6LPEINp86ILIe8Xl3YmIruMvjYfZWEzigv3M/WE4CmqJ3YLAaBVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yehQpvde; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so6558337e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723535495; x=1724140295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QRS1lyRh8lkYfCbdwZWOfosdPI8L0u4PZF6GCwulOk=;
        b=yehQpvdeziXCgfYzGrZksv8CduyOSZqQrb9doJ8FiFsh82PdbiMXpA2SNCfSOY+q7+
         86zGnygbu2mz8B3vJ6TUKVclxRDV3T2vl+OiG9dOzKpVpu62tx+EsLYzd2ReS0HPYRiX
         f26o7xUVJn6mvRsyBejPV1Rxmek13KDXkiXp0ep+5V6m9GBlN0IHLnYa4GjmGH9IjCXC
         FE95BNLnMZvmarlEoB0rnhpv/Ufq3vYVnRLcn26eMufH6VxCnlI9BV3HdGm6HYj4M5Mu
         sTObdrYzbTFkvwk5TsiALV1j1UxCXtrkVprnLgbgLppAPAf/BOCc+sIbAzbE4mmmTzIm
         +fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723535495; x=1724140295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QRS1lyRh8lkYfCbdwZWOfosdPI8L0u4PZF6GCwulOk=;
        b=f75ne09wdaq98ICjOhpt5sjleo10isIb57wTsL4G6dmPenwCoD+SrI661EU07M1Fb5
         3RNe2vRYeroVyNe+8a3K/MI7Ew6RrEAa/wXvGASADGJDF9BHr+ppU4absP0Ri2+j3I5V
         McPSyyQ53AF/9DNOZ1KsnrJm4cbSSbcfhqfpN4HdkIyV6lSXv8S5RdbKaUEEDLLD6mzv
         wQiIJYE/0ShDWcF4eoHwKrEa3vvsU/L0KNs4BkLkA3sxzdQlgQqXtwcBz+p02DUaPqpp
         tRH++Yc90khUne7M/hR8cuCqREMeyjw5lEnHSXogav8twXLj3CvDa3u/ZFXKD0UZ8kn3
         8yng==
X-Forwarded-Encrypted: i=1; AJvYcCUnvgKZF7Z+rajrBqPtarnQQmWHVd1fz0oMpnYsBe4rYFfipCTFSveZJt1slS3r4vjDDmEoJPX+deCmmjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EF+M1VbIy8fupCm+dD0JXQgykH1fQs5aW0qa9XyJTlTLrBg4
	JsqvHsd6nJd0A6hjERGn81NhgfZzxOWoPSIb4Ytxb3W8IBx7Vxj5PP3YKIrQcXo=
X-Google-Smtp-Source: AGHT+IHcF95tS5uvBKd4zCFN8i/7/kD9q4UxU5TuQGvqJTf6ojHKzzfUr5xtNQnSHMCGqq/qYMuU8w==
X-Received: by 2002:a05:6512:b29:b0:52c:e084:bb1e with SMTP id 2adb3069b0e04-5321365874dmr1868410e87.13.1723535494929;
        Tue, 13 Aug 2024 00:51:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa31c4sm46305966b.49.2024.08.13.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:51:34 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:51:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: error27@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: SVM: Fix an error code in
 sev_gmem_post_populate()
Message-ID: <bed4d818-ef19-4e87-8cdf-cca00d34e6f7@stanley.mountain>
References: <20240612115040.2423290-2-dan.carpenter@linaro.org>
 <20240612115040.2423290-4-dan.carpenter@linaro.org>
 <ZrrbSFVpVs0eX1ZQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrrbSFVpVs0eX1ZQ@google.com>

On Mon, Aug 12, 2024 at 09:04:24PM -0700, Sean Christopherson wrote:
> On Wed, Jun 12, 2024, Dan Carpenter wrote:
> > The copy_from_user() function returns the number of bytes which it
> > was not able to copy.  Return -EFAULT instead.
> 
> Unless I'm misreading the code and forgetting how all this works, this is
> intentional.  The direct caller treats any non-zero value as a error:
> 
> 		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
> 
> 		put_page(pfn_to_page(pfn));
> 		if (ret)
> 			break;
> 	}
> 
> 	filemap_invalidate_unlock(file->f_mapping);
> 
> 	fput(file);
> 	return ret && !i ? ret : i;
> 

No, you're not reading this correctly.  The loop is supposed to return the
number of pages which were handled successfully.  So this is saying that if the
first iteration fails and then return a negative error code.  But with the bug
then if the first iteration fails, it returns the number of bytes which failed.
The units are wrong pages vs bytes and the failure vs success is reversed.

Also I notice now that i isn't correct unless we hit a break statement:

virt/kvm/guest_memfd.c
   647          npages = min_t(ulong, slot->npages - (start_gfn - slot->base_gfn), npages);

If there isn't enough pages, we use what's available.

   648          for (i = 0; i < npages; i += (1 << max_order)) {

If we exit because i >= npages then we return success as if we were able to
complete one final iteration through the loop.

   649                  struct folio *folio;
   650                  gfn_t gfn = start_gfn + i;
   651                  bool is_prepared = false;
   652                  kvm_pfn_t pfn;
   653  
   654                  if (signal_pending(current)) {
   655                          ret = -EINTR;
   656                          break;
   657                  }
   658  
   659                  folio = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &is_prepared, &max_order);
   660                  if (IS_ERR(folio)) {
   661                          ret = PTR_ERR(folio);
   662                          break;
   663                  }
   664  
   665                  if (is_prepared) {
   666                          folio_unlock(folio);
   667                          folio_put(folio);
   668                          ret = -EEXIST;
   669                          break;
   670                  }
   671  
   672                  folio_unlock(folio);
   673                  WARN_ON(!IS_ALIGNED(gfn, 1 << max_order) ||
   674                          (npages - i) < (1 << max_order));
   675  
   676                  ret = -EINVAL;
   677                  while (!kvm_range_has_memory_attributes(kvm, gfn, gfn + (1 << max_order),
   678                                                          KVM_MEMORY_ATTRIBUTE_PRIVATE,
   679                                                          KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
   680                          if (!max_order)
   681                                  goto put_folio_and_exit;
   682                          max_order--;
   683                  }
   684  
   685                  p = src ? src + i * PAGE_SIZE : NULL;
   686                  ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
                        ^^^^^^^^^^^^^^^^^^^^
post_populate() is a pointer to sev_gmem_post_populate() which has is supposed
to return negative error codes but instead returns number of bytes which failed.

   687                  if (!ret)
   688                          kvm_gmem_mark_prepared(folio);
   689  
   690  put_folio_and_exit:
   691                  folio_put(folio);
   692                  if (ret)
   693                          break;
   694          }
   695  
   696          filemap_invalidate_unlock(file->f_mapping);
   697  
   698          fput(file);
   699          return ret && !i ? ret : i;
   700  }

regards,
dan carpenter


