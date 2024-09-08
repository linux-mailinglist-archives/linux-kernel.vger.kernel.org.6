Return-Path: <linux-kernel+bounces-320298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A897087B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE89282425
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041817335E;
	Sun,  8 Sep 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJsEKqlp"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD5EACD;
	Sun,  8 Sep 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810649; cv=none; b=PG2J35IFbebRiHv1NIolY2ZebBINPN7fH0f2cfu4Y15SBAlDzVob3YWv6IZauI4sq8rpAv14RFR1xr/a7tIl+64EiZOCykK2ryebTZF4/scByD807mMOJaF6CraUd1+DuDnWNEo4Jc2Ee/YygOHcKbt6YCIxVR06GNGlLQPOxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810649; c=relaxed/simple;
	bh=p7p7ve0rL0qkYlp22cJ0Muwaz170PAM8N3aHObPPd+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvKvsd0/8ACmSd46CaaSN/t8idYhH7erUGK8DtJd5fVxmw+2zQRQ3KvhBUKdwVYRqZh0XPXwNaPtfwOiBx8JwMGzh8Y6ahmCc75boVRvZSQ4a3CVFjO8x4I5YV8rW3psQDGWnWwctkEMxyeb/6mu8vWWv4FOJRXIjSgZrerfp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJsEKqlp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c35357cdacso22302776d6.0;
        Sun, 08 Sep 2024 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725810647; x=1726415447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDVIvP5tBXBLUu0lAesibIPrNNd7trVnMAnVCJrB2rw=;
        b=TJsEKqlpWiVkjgpBRZLgfW5rIcxj4z9IAhs6rqXUd3SamPLWxiHud0MeMyhPD0h7tR
         f9JD4LOz4kooz9XAv8+3OUTPDuPS6YAkvk4U373vJjVzDq8jA2BZ7XDaskLCOlAXVWNR
         hNEXgv80vH2kzr+No0hFN8EerxKiJcVgXsqiD3rADkS0FmJLXZaWnWfBJ+K2rX/H6d1G
         opBjgzB28MMukqfVAyHxz68RLF+P+yyVRZxTZQpDVv41BRiU13Mo0GTZ2y4XWU6DlEpi
         94oseAD9GWUKuvYDcdjiChKfxVCELsoUH6fQlyAG56Kt8Y+1CWFRL8HCGYbJD+9/xPqu
         ZPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725810647; x=1726415447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDVIvP5tBXBLUu0lAesibIPrNNd7trVnMAnVCJrB2rw=;
        b=MCWpmUKidMCZAcKATOAtpayN1UbnCHyHV4kdXj2GMtQbycSL1klHqGbB3ate9BrA06
         k5YWsBw8nCTumFozrZ2XxMagG6avzMOtO3xRvl1DAtnMfQYpWkKXf3B8i2/94aJefBGB
         Eb4WrHkAIJrWIv8eUyla2LfFAdTNS23ZXpPRwciLYmmwfNsbclBN7DVCxrleEesDlEF8
         rGGcHYu42HYKKyRiRQtSkayRyqxzzcv6Qpy3z0XN4ESOh8ZT8SvaV1Wk147pKXPJcZs7
         Ft65zp/l0HYG3NnS0LtoMLvPy/w0ssRvKSrhlB6QcEXuFqYqA6cqHE4Lbg3eBwfQ4hbl
         wsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8+MQvOdpsRAZfcilr1qm50GuYoc7g87Kox2o4t/BunKE2dy6CtL53DZa2NQxb8qA7dv+W6kZIZtw=@vger.kernel.org, AJvYcCVxjGWombnY+pGZGAwcJL1yE+uQjRmpPKn29WSQsczL2O07oWxOOlsXjgP1G5kn+UyzRNu9LltJpU0d/ovL@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHT4hLPH9Yh+rx0CRAW2t9Stvr5Pl/SyXuS8zQsdObXC+Y47J
	ipF3FIRapnc3RnsnNzKNPKNIx4L23IDRRKEoYHTGVVhS3aN8QK90NiclNg5GcYg=
X-Google-Smtp-Source: AGHT+IHA07WpeNTAGvP117KDFNgKRjh6MuFujc4Yiwpw3h01mxSEnwknMWpyciRS1qEnDQ7sZpBucw==
X-Received: by 2002:a05:6214:3f8e:b0:6c3:5ebb:9526 with SMTP id 6a1803df08f44-6c5284f9132mr99054776d6.29.1725810646677;
        Sun, 08 Sep 2024 08:50:46 -0700 (PDT)
Received: from ip-172-31-16-54.ec2.internal (ec2-52-90-172-172.compute-1.amazonaws.com. [52.90.172.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534774679sm13543496d6.120.2024.09.08.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 08:50:46 -0700 (PDT)
From: Takahiro Itazuri <zulinx86@gmail.com>
To: pawan.kumar.gupta@linux.intel.com,
	corbet@lwn.net,
	jani.nikula@linux.intel.com
Cc: bp@alien8.de,
	jpoimboe@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	zulinx86@gmail.com
Subject: Re: [PATCH v2] Documentation: Use grid table over list table
Date: Sun,  8 Sep 2024 15:50:43 +0000
Message-Id: <20240908155043.556286-1-zulinx86@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906172317.ohiokq7fzoc5emnq@desk>
References: <20240906172317.ohiokq7fzoc5emnq@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 6 Sep 2024, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> On Fri, Sep 06, 2024 at 04:26:49PM +0300, Jani Nikula wrote:
> > On Fri, 06 Sep 2024, Takahiro Itazuri <itazur@amazon.com> wrote:
> > > Using a simple table, a line break in the first column would be
> > > recognized as two rows. To avoid that, list table was used but it
> > > is unreadable for plain text readers. Uses grid table instead.
> > >
> > > Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> > > ---
> > > Changes in v2:
> > > - Use grid table over list table (applying to not only GDS but also
> > >   other vulnerabilities)
> > > - Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/
> > 
> > I see that Jon asked you to use a grid table.
> > 
> > But when I look at what's being changed, I can't help but think a
> > definition list [1] might provide the best compromise between readable
> > (and easily editable!) source rst and generated html. I don't think it
> > has to be a *table* in either.

Thank you for your feedback!

Then, I'd prefer list table again because it doesn't change the existing HTML
appearance and it doesn't look much different from the definition list in plain
text format.

For readability/editability in plain text format, a line break can be inserted
between items as follows:

.. list-table::

   * - 'Not affected'
     - Processor not vulnerable.

   * - 'Vulnerable'
     - Processor vulnerable and mitigation disabled.

   * - 'Vulnerable: No microcode'
     - Processor vulnerable and microcode is missing migitation.

   * - 'Mitigation: AVX disabled, no microcode'
     - Processor is vulnerable and microcode is missing mitigation. AVX disbaled as
       mitigation.

   * - 'Mitigation: Microcode'
     - Processor is vulnerable and mitigation is in effect.

   * - 'Mitigation: Microcode (locked)'
     - Processor is vulnerable and mitigation is in effect and cannot be disabled.

   * - 'Unknown: Dependent on hypervisor status'
     - Running on a virtual guest processor that is affected but with no way to
       know if host processor is mitigated or vulnerable.

Thanks,
Taka

