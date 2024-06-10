Return-Path: <linux-kernel+bounces-209002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4291902BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9481C21C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C31509A2;
	Mon, 10 Jun 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvvlgX52"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F42152166
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058409; cv=none; b=osqfmxjvGpxpGKzRy/yLP2wANCVLlCYEXgd67+kY9O24hJbJCeiieQD1I5d3nxgG97aWdh8pyM9+0AlHylCdUOYaEB17mahgZfbKGG325NEcNy251Ils94TOtR6NtUpM1qkNaHXpbqw4Fpus6ZxDpS8s/s9whLSb+op/6zWvOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058409; c=relaxed/simple;
	bh=Ttt2S1GLUXZEd0ttG8HJqv5c1GCofEnDliwLMN8ASi0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OJGctC4/KSQFP9mp6xOqSmM4MugzR1ZB9SeWh1VMxyCl01Zft8zV4FQE19jWYHwGajTA/K6JaY0pWVjkWAzwG1hLbb57WsXlr6MbhfIvuEpbMcf0NOCLmZOlFaGRjZ7veA2RcsaEScs2IarTlebr08Yc8ujwPdJMDRtWmPSn0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvvlgX52; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718058405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9kL6Zc7WYoNhZHgv+dGyL7hASvgvBIXKuIjHy044BLg=;
	b=DvvlgX529psJfOpowihSx7kDQfOzxZyehYaXbaTxjkArkSjxIXw3mnBm4JA6LPrGl5cFPO
	fSFDHFzUQJ/XoJoYZe2BLxwH74RXjvm6vgKHOpc+kQeoQ/XdLmxZ/8cFFKfQe4ycY1w5Eg
	FUS9YnuRARYo5PtqATBZxnocoYK3iBQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-5oNF3kogOvmmmom7Xz2VYA-1; Mon, 10 Jun 2024 18:26:44 -0400
X-MC-Unique: 5oNF3kogOvmmmom7Xz2VYA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6efe58a1aeso149841766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058403; x=1718663203;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kL6Zc7WYoNhZHgv+dGyL7hASvgvBIXKuIjHy044BLg=;
        b=EJ2wHmWE353YYwFBm1vXeLbl2GcDRyqevw4m+ClUD+j1mM2hC5bxyXWNdbWGFWul6W
         AhfPl7mFGzhbxQZY8XVG/Caee2A7boRrrx/ZJEIdWJ/Ftnafl1ljH5n9XaLlwff5zwHX
         M+pKo/EfSJzpGfzMj5X4rONAZ6nqToItks7ODTomjXQcHnI0teLk7INELkRYJS9Bf6vR
         siCLCeSDrYLVIeApbFs8Tn2QISFx5gQnuyjtxsyLREgMFsJTjcKHsIeOL1he4WiGyJ1n
         4nRtpGvlyEIzAsc08F4IaHAwssQv31e+ZxDhkhFGQrLM6+ry4ofbT8R047PksiPguIav
         e0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUnp04BzoRpcZ+IY1y/LGvo40GTSvx6L3p24zRk7OQIdibAkvcCmhgG8g0V6u5vZJ6WFXj22iM9+HEroR9BOGg9FFpc6/mPaRTmag+N
X-Gm-Message-State: AOJu0YzMY593gvrLvk5uBSuGlaIR9EdAGYHUNNBLZceVHy2vPBRzOIrC
	K1Q66jHGruLEwT2FSJjF335Qjg+tpzCf918y13qrw6qk6czdseZBKjp2gG2kZjj/ZeleXhHWaya
	lSOzXWhqMrRveV42+xv/i5skASJqWXWDW33Pqf66Ao9bievrF+pix096qudopaA==
X-Received: by 2002:a17:906:3285:b0:a68:2f99:a3da with SMTP id a640c23a62f3a-a6cd5612575mr653621066b.16.1718058402868;
        Mon, 10 Jun 2024 15:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmXQHqvyBx+7NC1VAXwfuIUTxIM+AmkXBpGAsw7bOayrc/OkpNyFl+BFyJ5/1VTlcoxQcVcQ==
X-Received: by 2002:a17:906:3285:b0:a68:2f99:a3da with SMTP id a640c23a62f3a-a6cd5612575mr653620566b.16.1718058402410;
        Mon, 10 Jun 2024 15:26:42 -0700 (PDT)
Received: from [192.168.10.3] ([151.62.196.71])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f0e47b8f7sm341865766b.31.2024.06.10.15.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:26:41 -0700 (PDT)
Message-ID: <de1b0bbc-b781-4372-88ad-81f26c9152c2@redhat.com>
Date: Tue, 11 Jun 2024 00:26:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, michael.roth@amd.com, isaku.yamahata@linux.intel.com
References: <20240404185034.3184582-1-pbonzini@redhat.com>
 <20240404185034.3184582-10-pbonzini@redhat.com>
 <20240423235013.GO3596705@ls.amr.corp.intel.com>
 <ZimGulY6qyxt6ylO@google.com>
 <20240425011248.GP3596705@ls.amr.corp.intel.com>
 <CABgObfY2TOb6cJnFkpxWjkAmbYSRGkXGx=+-241tRx=OG-yAZQ@mail.gmail.com>
 <Zip-JsAB5TIRDJVl@google.com>
 <CABgObfaxAd_J5ufr+rOcND=-NWrOzVsvavoaXuFw_cwDd+e9aA@mail.gmail.com>
 <ZivFbu0WI4qx8zre@google.com> <ZmORqYFhE73AdQB6@google.com>
 <CABgObfYD+RaLwGgC_nhkP81OMy3-NvLVqu9MKFM3LcNzc7MCow@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <CABgObfYD+RaLwGgC_nhkP81OMy3-NvLVqu9MKFM3LcNzc7MCow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 23:48, Paolo Bonzini wrote:
> On Sat, Jun 8, 2024 at 1:03 AM Sean Christopherson <seanjc@google.com> wrote:
>> SNP folks and/or Paolo, what's the plan for this?  I don't see how what's sitting
>> in kvm/next can possibly be correct without conditioning population on the folio
>> being !uptodate.
> 
> I don't think I have time to look at it closely until Friday; but
> thanks for reminding me.

Ok, I'm officially confused.  I think I understand what you did in your
suggested code.  Limiting it to the bare minimum (keeping the callback
instead of CONFIG_HAVE_KVM_GMEM_INITIALIZE) it would be something
like what I include at the end of the message.

But the discussion upthread was about whether to do the check for
RMP state in sev.c, or do it in common code using folio_mark_uptodate().
I am not sure what you mean by "cannot possibly be correct", and
whether it's referring to kvm_gmem_populate() in general or the
callback in sev_gmem_post_populate().

The change below looks like just an optimization to me, which
suggests that I'm missing something glaring.

Paolo

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d4206e53a9c81..a0417ef5b86eb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -52,37 +52,39 @@ static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct fol
  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prepare)
  {
  	struct folio *folio;
+	int r;
  
  	/* TODO: Support huge pages. */
  	folio = filemap_grab_folio(inode->i_mapping, index);
  	if (IS_ERR(folio))
  		return folio;
  
-	/*
-	 * Use the up-to-date flag to track whether or not the memory has been
-	 * zeroed before being handed off to the guest.  There is no backing
-	 * storage for the memory, so the folio will remain up-to-date until
-	 * it's removed.
-	 *
-	 * TODO: Skip clearing pages when trusted firmware will do it when
-	 * assigning memory to the guest.
-	 */
-	if (!folio_test_uptodate(folio)) {
-		unsigned long nr_pages = folio_nr_pages(folio);
-		unsigned long i;
+	if (prepare) {
+		/*
+		 * Use the up-to-date flag to track whether or not the memory has
+		 * been handed off to the guest.  There is no backing storage for
+		 * the memory, so the folio will remain up-to-date until it's
+		 * removed.
+		 *
+		 * Take the occasion of the first prepare operation to clear it.
+		 */
+		if (!folio_test_uptodate(folio)) {
+			unsigned long nr_pages = folio_nr_pages(folio);
+			unsigned long i;
  
-		for (i = 0; i < nr_pages; i++)
-			clear_highpage(folio_page(folio, i));
+			for (i = 0; i < nr_pages; i++)
+				clear_highpage(folio_page(folio, i));
+		}
+
+		r = kvm_gmem_prepare_folio(inode, index, folio);
+		if (r < 0)
+			goto err_unlock_put;
  
  		folio_mark_uptodate(folio);
-	}
-
-	if (prepare) {
-		int r =	kvm_gmem_prepare_folio(inode, index, folio);
-		if (r < 0) {
-			folio_unlock(folio);
-			folio_put(folio);
-			return ERR_PTR(r);
+	} else {
+		if (folio_test_uptodate(folio)) {
+			r = -EEXIST;
+			goto err_unlock_put;
  		}
  	}
  
@@ -91,6 +93,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool
  	 * unevictable and there is no storage to write back to.
  	 */
  	return folio;
+
+err_unlock_put:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ERR_PTR(r);
  }
  
  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
@@ -545,8 +552,15 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
  	fput(file);
  }
  
+/* If p_folio is NULL, the folio is cleared, prepared and marked up-to-date
+ * before returning.
+ *
+ * If p_folio is not NULL, this is left to the caller, who must call
+ * folio_mark_uptodate() once the page is ready for use by the guest.
+ */
  static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
-		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
+		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order,
+		       struct folio **p_folio)
  {
  	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
  	struct kvm_gmem *gmem = file->private_data;
@@ -565,7 +579,7 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
  		return -EIO;
  	}
  
-	folio = kvm_gmem_get_folio(file_inode(file), index, prepare);
+	folio = kvm_gmem_get_folio(file_inode(file), index, !p_folio);
  	if (IS_ERR(folio))
  		return PTR_ERR(folio);
  
@@ -577,6 +591,8 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
  	page = folio_file_page(folio, index);
  
  	*pfn = page_to_pfn(page);
+	if (p_folio)
+		*p_folio = folio;
  	if (max_order)
  		*max_order = 0;
  
@@ -597,7 +613,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
  	if (!file)
  		return -EFAULT;
  
-	r = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, true);
+	r = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, NULL);
  	fput(file);
  	return r;
  }
@@ -629,10 +645,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
  
  	npages = min_t(ulong, slot->npages - (start_gfn - slot->base_gfn), npages);
  	for (i = 0; i < npages; i += (1 << max_order)) {
+		struct folio *folio;
  		gfn_t gfn = start_gfn + i;
  		kvm_pfn_t pfn;
  
-		ret = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, false);
+		ret = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, &folio);
  		if (ret)
  			break;
  
@@ -642,8 +659,10 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
  
  		p = src ? src + i * PAGE_SIZE : NULL;
  		ret = post_populate(kvm, gfn, pfn, p, max_order, opaque);
+		if (!ret)
+			folio_mark_uptodate(folio);
  
-		put_page(pfn_to_page(pfn));
+		folio_put(folio);
  		if (ret)
  			break;
  	}



