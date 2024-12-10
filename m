Return-Path: <linux-kernel+bounces-440235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1A9EBA90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444E01885361
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2922687A;
	Tue, 10 Dec 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tfofUbI"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F91D356E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861042; cv=none; b=YrIoCT5EOEDCuCcwybK4+wSuqhjLA9DK2ZFZ4/OFVj2YCNKkbBEfshcnsviS1zRAYNVNgk0DByWJGOtoGi9UqjLwodGzOmo/ZDhetzVumwcx6VyrPuz17BGi3iUs5FATKxafv58Nn5MqvwbVv536Hh4lbh4OnQ3xlaK/uD0vIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861042; c=relaxed/simple;
	bh=HthPYyWXM7ns7qJH1oxyyCxcTrMM61ei5KKI8AyghW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmAgBOqy9q12QAMPGmzqW01JG6ZlbcxUsbGT+BQXyFr2z9HHgqwkui3VR1eHSy1iscmw3WtUK33xgf8plj93pgC+2yD0C9oTTZ2TqtDWuJ39mBDIWyije4fYLP1i3+2RtsS0fyJ4JIPV3n1C7DhiOEsrsANsPThSm0pzbqrv42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tfofUbI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fd48914d9bso1999999a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861040; x=1734465840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b12YP6LI5CxDMhQYfb1Kc2Pt0Ydr8IAu1z7uO7m4AgE=;
        b=2tfofUbIx0yQiykosn9k27ps5u2wGOTNVFC2rD6w9AsQsXbL3PpnLpY5k4/9LT6TRk
         AaFqixDmbw0aio+yXopjOtQFSU7lClp1l1nBREW/jQayJqGmsyeRZoH8MIdPBh151RxP
         ae2J5+yI+mx1HNCrEEFEmM7J+IZFE8lyhqiyYiNAVsxAflDA5+tOUHGIHGxJBWmL3BIP
         jkpGNYTDsG21NO/NxNiwyX7LmBbqgghhaLNP8Mp0/URWW3uaSgKlo1A/Rsv+qng3sZYx
         lh9ldC4Q2dCboBA5AjIRQ+CVBUI6ilaMC1uWGkzKMiYsX6ztXTRqYnwxB6KtBedmeR+R
         POtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861040; x=1734465840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b12YP6LI5CxDMhQYfb1Kc2Pt0Ydr8IAu1z7uO7m4AgE=;
        b=AN66N+3MKZ4/mhTSsR/hu2LjFSsF75wuL2ulgpCwKH987J1Q7EQ0r84FcmQT83LOW1
         K9bD7TBXIRloz+2HB7jA5818VCjaOIt4r+Ep7kYU4DHL6W+UKzlD8X2bNt3bgJyDn5Nd
         ASswVtF6ShEyOBR/joOqz/uW+Valt4YDIQOj8icMHE/wMFCzwGjDl/JnkPBiK6I7DzxO
         wmGsTqih9h6IQi0wZZuXFCT5GhbQ+oVzBw/JK0qmvgX/T/V4GHA7VsWcwjX2hZey+2Go
         CpdnV/O8+R1FHxYMJL4xh8ThC0rGhFf6eu4lKcLVRwUAcaIm61h3Ias5YLsq9K2lwX4l
         I6UA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLOPWRzAoyZrJD8e8t1OYTBtZfTGBHQf232VH0hAXcTQk+vgQuyiLxAOZNKaC/NTAC6OZxoEST/5iDdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvowDMThhz1auN2qOAPoe+4DSDSQWIiLrsSUkt3DP49aqpmQL
	/YSN0CstyT4rCMqaYzEdKKXydaHp23xZ+F35djfTdXscbHYu0j7DeXbuumpAGqDLSNldQkxaCSw
	+Hg==
X-Google-Smtp-Source: AGHT+IGKnq0xwIL8hClvKg5o4OLBAI7YS3m+WXsr/V1moELCfZa0g1+/9+ClUPgspDlb4HQmNU67QxV+TNc=
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2ef:89a5:7810])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c52:b0:2ea:4c4f:bd20
 with SMTP id 98e67ed59e1d1-2f12804deeemr332807a91.32.1733861040651; Tue, 10
 Dec 2024 12:04:00 -0800 (PST)
Date: Tue, 10 Dec 2024 12:03:59 -0800
In-Reply-To: <6423ec9d-46a2-43a3-ae9a-8e074337cd84@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com> <20241128004344.4072099-7-seanjc@google.com>
 <90577aad-552a-4cf8-a4a3-a4efcf997455@intel.com> <6423ec9d-46a2-43a3-ae9a-8e074337cd84@redhat.com>
Message-ID: <Z1ier7QAy9qj7x4V@google.com>
Subject: Re: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into
 a macro
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 10, 2024, Paolo Bonzini wrote:
> On 11/28/24 09:38, Adrian Hunter wrote:
> > 
> > For TDX, there is an RFC relating to using descriptively
> > named parameters instead of register names for tdh_vp_enter():
> > 
> > 	https://lore.kernel.org/all/fa817f29-e3ba-4c54-8600-e28cf6ab1953@intel.com/
> > 
> > Please do give some feedback on that approach.  Note we
> > need both KVM and x86 maintainer approval for SEAMCALL
> > wrappers like tdh_vp_enter().
> > 
> > As proposed, that ends up with putting the values back into
> > vcpu->arch.regs[] for __kvm_emulate_hypercall() which is not
> > pretty:
> 
> If needed we can revert this patch, it's not a big problem.

I don't care terribly about the SEAMCALL interfaces.  I have opinions on what
would I think would be ideal, but I can live with whatever.

What I do deeply care about though is consistency within KVM, across vendors and
VM flavors.  And that means that guest registers absolutely need to be captured in
vcpu->arch.regs[].  TDX already requires too much special cased code in KVM, there
is zero reason to make TDX even more different and thus more difficult to maintain.

