Return-Path: <linux-kernel+bounces-330355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41310979D08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01204280AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C7149DF4;
	Mon, 16 Sep 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3kVF+nq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE51459E0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476013; cv=none; b=eVHm0HV6Lbr4ijpwHf8lVi2BS6o5GoVVjUS46ay0piyy9p9Y3bL+G4s3rL3YhYUQKqCgMPbu5mbh9p3WjKzpxtRSrY0J+QFeBhB9taWzKW7uM5owCMl/b/rmkic6P8EBL4J4Y+GQEKmC2lrglS5lsC7/BhKLdCIguPTR6P7BQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476013; c=relaxed/simple;
	bh=3tezeYk8/oQD4basQb0gA+dGgId/HoFid+ijykAqs54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnO8WjKIbpI6peAMaGWHyPDrZT959lQc+ojghzjfz10PZ5ZltBIqihicDumyT8eT9yGnWvT876dlvwyCCyM40z0zsGAnbCMq7IgPV+H29SS3ZoxBngazOeM/4IYBwBzh/ZtjVj+eT+8sHmcJlcJaueOMabFwljBPZHYg9mx14Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3kVF+nq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726476010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veTIA8crxMcOp+vthNk0ANAtv78UFR8BCP1ThmDnOAE=;
	b=e3kVF+nqJd8HTM5/5sGwW3cQzn94SGRnt0GmhCYz12GPjyFfPs+XOGQrSmp9SlsmzX3LqM
	i5xG8EI2gXpVzfB5xEUhlAWhfnNa0rE4gOpd13TV6qTgpLVg7YDhqRr1nfWj9OGsjmIs1j
	WurF9yfDhOk93SVWtCUWCrVYoDnbUzA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-mOWl9oypMHiBU-SmyDzNUA-1; Mon, 16 Sep 2024 04:40:09 -0400
X-MC-Unique: mOWl9oypMHiBU-SmyDzNUA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bb2f100fso1425137f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726476008; x=1727080808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veTIA8crxMcOp+vthNk0ANAtv78UFR8BCP1ThmDnOAE=;
        b=U0FlpEmkNMPLquAWnpeApKZaYJtsNK2d7tKOPYpmusd6C1PZKnQ1Pa3Gz38KKKhhUV
         JDsS7HmgAP/oTqlATCWi/xx8YZW3tl5xJaVeeVM+M9TEUzLzbIcS55zlGG8Nedj3jR7H
         W/EA2nqxiJ7O1djd3k9tXD5JyzERTyIQwAgGx+AiSj9RxGfBwpCnaT5AyAlYz9EcoeAU
         MpkZcRdDBiSPUqIZTsT8+yEiXOOxg7HpFFMgP1RlO8AcX4QW+Of/br6ozwcHrXsNoqXV
         3bZdNaxJkJjBvMEs9gaF0aCArsouYFiAIPFg00RTtJBRW+aYvLqzv+BqG388B66i8qag
         0Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCUVwjtTLf1FDaY/KHXuRUNST6UpTULoQRQJlVRy4++q+UljfZB06eNto9cIu7nVpadwuGcUtNCLFXwXdvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iPmNcguuYYok4xr3dhIhkUGlm3yWyxrxv2GAKfuHqKWcc0Tf
	l5R6WEag+ASUmqeIQGJm73i32sxGub0quMQkwlAxN3jS7PKdMAKPerMjGaCGpAeUN97+sJ6ENq0
	SVz0RcHBmxcW9PPqEoygmF4VMFLtq+bVr4hUD2Ytm0M8+OYTB/QapAcxP5rTo8A==
X-Received: by 2002:adf:a458:0:b0:374:bfe5:bbf2 with SMTP id ffacd0b85a97d-378c2cfec81mr8291025f8f.23.1726476007644;
        Mon, 16 Sep 2024 01:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjkHKX55+OZKHOULxziyOYPMnm544RHvaoALWM7Ap8oLjTHl78WxK78L7OHW+ju2++VNt0UA==
X-Received: by 2002:adf:a458:0:b0:374:bfe5:bbf2 with SMTP id ffacd0b85a97d-378c2cfec81mr8290979f8f.23.1726476006731;
        Mon, 16 Sep 2024 01:40:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7804483sm6523541f8f.92.2024.09.16.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:40:05 -0700 (PDT)
Date: Mon, 16 Sep 2024 04:40:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Srujana Challa <schalla@marvell.com>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: drivers/vdpa/octeon_ep/octep_vdpa_hw.c:143 octep_process_mbox()
 warn: missing error code? 'ret'
Message-ID: <20240916043819-mutt-send-email-mst@kernel.org>
References: <7e8141cb-44e6-477c-b77e-aa9b4bc5af3a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8141cb-44e6-477c-b77e-aa9b4bc5af3a@stanley.mountain>

On Mon, Sep 16, 2024 at 10:35:28AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98f7e32f20d28ec452afb208f9cffc08448a2652
> commit: 8b6c724cdab85d8923dd8c474a5a9464228379c5 virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices
> date:   10 weeks ago
> config: i386-randconfig-141-20240912 (https://download.01.org/0day-ci/archive/20240916/202409160431.bRhZWhiU-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202409160431.bRhZWhiU-lkp@intel.com/
> 
> New smatch warnings:
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:143 octep_process_mbox() warn: missing error code? 'ret'
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:478 octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast from pointer
> 
> Old smatch warnings:
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:479 octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast from pointer
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:480 octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast from pointer
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:481 octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast from pointer
> drivers/vdpa/octeon_ep/octep_vdpa_hw.c:514 octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast from pointer
> 
> vim +/ret +143 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> 
> 8b6c724cdab85d Srujana Challa 2024-06-14  102  static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid, void *buffer,
> 8b6c724cdab85d Srujana Challa 2024-06-14  103  			      u32 buf_size, bool write)
> 8b6c724cdab85d Srujana Challa 2024-06-14  104  {
> 8b6c724cdab85d Srujana Challa 2024-06-14  105  	struct octep_mbox __iomem *mbox = octep_get_mbox(oct_hw);
> 8b6c724cdab85d Srujana Challa 2024-06-14  106  	struct pci_dev *pdev = oct_hw->pdev;
> 8b6c724cdab85d Srujana Challa 2024-06-14  107  	u32 *p = (u32 *)buffer;
> 8b6c724cdab85d Srujana Challa 2024-06-14  108  	u16 data_wds;
> 8b6c724cdab85d Srujana Challa 2024-06-14  109  	int ret, i;
> 8b6c724cdab85d Srujana Challa 2024-06-14  110  	u32 val;
> 8b6c724cdab85d Srujana Challa 2024-06-14  111  
> 8b6c724cdab85d Srujana Challa 2024-06-14  112  	if (!IS_ALIGNED(buf_size, 4))
> 8b6c724cdab85d Srujana Challa 2024-06-14  113  		return -EINVAL;
> 8b6c724cdab85d Srujana Challa 2024-06-14  114  
> 8b6c724cdab85d Srujana Challa 2024-06-14  115  	/* Make sure mbox space is available */
> 8b6c724cdab85d Srujana Challa 2024-06-14  116  	ret = octep_wait_for_mbox_avail(mbox);
> 8b6c724cdab85d Srujana Challa 2024-06-14  117  	if (ret) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  118  		dev_warn(&pdev->dev, "Timeout waiting for previous mbox data to be consumed\n");
> 8b6c724cdab85d Srujana Challa 2024-06-14  119  		return ret;
> 8b6c724cdab85d Srujana Challa 2024-06-14  120  	}
> 8b6c724cdab85d Srujana Challa 2024-06-14  121  	data_wds = buf_size / 4;
> 8b6c724cdab85d Srujana Challa 2024-06-14  122  
> 8b6c724cdab85d Srujana Challa 2024-06-14  123  	if (write) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  124  		for (i = 1; i <= data_wds; i++) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  125  			octep_write32_word(mbox, i, *p);
> 8b6c724cdab85d Srujana Challa 2024-06-14  126  			p++;
> 8b6c724cdab85d Srujana Challa 2024-06-14  127  		}
> 8b6c724cdab85d Srujana Challa 2024-06-14  128  	}
> 8b6c724cdab85d Srujana Challa 2024-06-14  129  	octep_write32_word(mbox, 0, (u32)qid);
> 8b6c724cdab85d Srujana Challa 2024-06-14  130  	octep_write_sts(mbox, 0);
> 8b6c724cdab85d Srujana Challa 2024-06-14  131  
> 8b6c724cdab85d Srujana Challa 2024-06-14  132  	octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> 8b6c724cdab85d Srujana Challa 2024-06-14  133  
> 8b6c724cdab85d Srujana Challa 2024-06-14  134  	ret = octep_wait_for_mbox_rsp(mbox);
> 8b6c724cdab85d Srujana Challa 2024-06-14  135  	if (ret) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  136  		dev_warn(&pdev->dev, "Timeout waiting for mbox : %d response\n", id);
> 8b6c724cdab85d Srujana Challa 2024-06-14  137  		return ret;
> 8b6c724cdab85d Srujana Challa 2024-06-14  138  	}
> 8b6c724cdab85d Srujana Challa 2024-06-14  139  
> 8b6c724cdab85d Srujana Challa 2024-06-14  140  	val = octep_read_sig(mbox);
> 8b6c724cdab85d Srujana Challa 2024-06-14  141  	if ((val & 0xFFFF) != MBOX_RSP_SIG) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  142  		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d response\n", id);
> 8b6c724cdab85d Srujana Challa 2024-06-14 @143  		return ret;
> 
> return -EINVAL;
> 
> The other warnings are because we should use %p to print pointers.  Depening on
> the .config the kernel will mask out pointers so that they aren't disclosed to
> the users.  Otherwise it risks being an information leak to defeat KSALR.
> 
> 8b6c724cdab85d Srujana Challa 2024-06-14  144  	}
> 8b6c724cdab85d Srujana Challa 2024-06-14  145  
> 8b6c724cdab85d Srujana Challa 2024-06-14  146  	val = octep_read_sts(mbox);
> 8b6c724cdab85d Srujana Challa 2024-06-14  147  	if (val & MBOX_RC_MASK) {
> 8b6c724cdab85d Srujana Challa 2024-06-14  148  		ret = MBOX_RSP_TO_ERR(val);
> 8b6c724cdab85d Srujana Challa 2024-06-14  149  		dev_warn(&pdev->dev, "Error while processing mbox : %d, err %d\n", id, ret);
> 8b6c724cdab85d Srujana Challa 2024-06-14  150  		return ret;
> 8b6c724cdab85d Srujana Challa 2024-06-14  151  	}
> 8b6c724cdab85d Srujana Challa 2024-06-14  152  
> 8b6c724cdab85d Srujana Challa 2024-06-14  153  	if (!write)
> 8b6c724cdab85d Srujana Challa 2024-06-14  154  		for (i = 1; i <= data_wds; i++)
> 8b6c724cdab85d Srujana Challa 2024-06-14  155  			*p++ = octep_read32_word(mbox, i);
> 8b6c724cdab85d Srujana Challa 2024-06-14  156  
> 8b6c724cdab85d Srujana Challa 2024-06-14  157  	return 0;
> 8b6c724cdab85d Srujana Challa 2024-06-14  158  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


Indeed. 
Srujana Challa, pls post a fixup patch ASAP, I will squash it.

-- 
MST


