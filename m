Return-Path: <linux-kernel+bounces-354916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37984994481
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E24B231BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB218BBA7;
	Tue,  8 Oct 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="UpYzFhen"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B442A9F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380514; cv=none; b=JJWwLdq40MUqadHXdPAqsgStUHrF9xh3djeppYeoZv2bBvXJ89bbzvrDz6t6ON446hw0irQgDrpfzXrww/XdpUmvo9/1sK08rOFozSWqaa082xfDtIKH20js/h6BQ0AVl/x5MNMx5JDuVm/XfXch2Kn9+8t9khz6GnWGUn3k+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380514; c=relaxed/simple;
	bh=Mo2e9NcdYS31B/vIw3xECB9NV30Pu2FvtUdn6fYteX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVEh09nRzSbAoYLr5G8iUaGyb0XN36C0jUTN2hRSC+PACbkU/hkcTW3KHYEr3UZwPy8BS9r92N0RmK9SVoktcUBVQYaKjMGSr1fGCXRBdn26wgBEdGMkn3vzQVMoc8hOaS5bQslwCP6rAZEFsw51zlJDmMdoU9K8NShDiq4d7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=UpYzFhen; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7eb9e81eso64343095ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 02:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1728380511; x=1728985311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0nlWa2ec/d6j0ayZKA64vJRenf3pukJl1StuKCsSzE=;
        b=UpYzFhenOV96QdrzTVBexAZ1uNW4bIsI/ioF1STQxBxKezKu3FCMOnNimpeATPAhpA
         UzVnNXTfzCY+RY82/IJVEceta+OO+zaPM9DJJeERTkrLVGO5+ZJpQAQR0J7/qNJ3SK9J
         xQlfH3XjXRIUkxZy+EnmozN/KC0yFIWHib8mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380511; x=1728985311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0nlWa2ec/d6j0ayZKA64vJRenf3pukJl1StuKCsSzE=;
        b=fqte27xj3naTEqPo1r26J3RvakCrr4YV1D9/ZcQAm0Np5E16jrHR1XW4C92Pdn4CZA
         oWsNrLpB+9clnJf8fMrE4CYuzEB/DD50BJ7boqL3hbGXCi1APgOnknTsVntEG2ZU0yun
         6/KOtVevbCk7DCT45g0edFtxeZUVibxcHG0fFvHOHzCW/7qv7hzgBzi3z4IKLRBz+leT
         O4mHfG/ywJvPGENn4yK1eUamQaDrMlGOReIIERKx4/vT2EqOCiFbcgfbGrs7HPbUtwUQ
         jcHFDxXT3N0yjrj7XQ4pd7JJXI5crIO12WivezlfV9XzAVV0xlbIP6r/7Nqoq0mBzLdO
         fGjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9lALZYx597MeDUaTWKbgDoXhYxk1AeWQ/WWa9JFrgTQ9Qjr+giMqs1OeZolKrtzOte+C8qZZBDPl4g5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISV5q94sgmbqa+tgrTWnmupzxfPCN4VTL97mEFKNGRR7QhN+Q
	77/n88cQ/rXiW9YZqZwWM5OjUpnVbHUaghfm86/rX0LtcCy6izFUiZvwZwEdoqVCzWOBwtOurGH
	Hl24=
X-Google-Smtp-Source: AGHT+IHf0bVYhdGwPLwPXuj7BNLWoONxtuBYeGxYm25ifrcUMzWiS6UprDQ5Dxhaf8AHR6liCx6HXg==
X-Received: by 2002:a05:6a20:438c:b0:1d6:2378:58ea with SMTP id adf61e73a8af0-1d6df73047emr22517140637.0.1728380511096;
        Tue, 08 Oct 2024 02:41:51 -0700 (PDT)
Received: from fedora ([103.3.204.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968d98sm52088485ad.184.2024.10.08.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:41:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:11:45 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm-hotfixes
 tree
Message-ID: <5y2aqwtuqyrfze6mrinnynhrbfrjtd5bsu6yb7quyzr6lqknd4@qiyaxleyj2ax>
References: <20241008074720.1a18a325@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20241008074720.1a18a325@canb.auug.org.au>

On 08.10.2024 07:47, Stephen Rothwell wrote:
>Hi all,
>
>Commit
>
>  922e46ae7737 ("mm: fix null pointer dereference in pfnmap_lockdep_assert")
>
>is missing a Signed-off-by from its author.
>
Hi all, I am the author of this patch. I forgot to sign it. Should I send a new
patch version to amend the mistake?

Sorry, I am new to kernel development.

-- 
Manas

