Return-Path: <linux-kernel+bounces-524619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1954A3E530
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2015423280
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206426462B;
	Thu, 20 Feb 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P6q3WhjE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B3264615
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080160; cv=none; b=MwReMSXtgXTohltbjGOrboLqE2yPM4Ji1d4C+CKH2Xxr60uFlrod6aLubBh1bEuJnGyYmLzgEEouhfIXSRclKFD2+N8OL7EenppSH1Xs0ZatCtHBdKbaL1qJHpmCsdEY6JVIFPbV7nkiwO7ceXRviwXMGmME3z/U2HyAu1zv/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080160; c=relaxed/simple;
	bh=r9sumPUkFDAwd49TGJqDeaX3rB6YkrFT+aTeUwfTG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwRQph57B3xr/2IyLDhU693nUI1PpelHH9Nxf0TJDud+D3/SPupa5fZF0nQFc1ETdFhbOIR9L78CImewipyapHZSikOPqSh0sMfoBX13+vlgXYxhkjrAA1yXQKbcZs5Z44emq+ORiLCanv9g4G1KJkks1hJviTM00jUpo2Fu4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P6q3WhjE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c09d7bb33bso99327485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740080158; x=1740684958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aq0auaV2gz0U2k7ZsV3xhtnt/Z87hJ6m6ZAx0KCC4ZY=;
        b=P6q3WhjEO/55iw+vaIfRatEQB8PzMI7Sbdu9qiLc5FG/+cLwtOerlJFRd9OEK+53Db
         7occM8KGTcT3DIMS9aL8TqznfurrCJXP1zCFfugEaUWK1cAjh3Nwn4X/Ru14M4btWkge
         LWf6bAA++h1G7lU3GDXjMUni0yRXV98FBb+i0qShXvl0LSnLiafi8aPdE4hQ0sQhfPDn
         15bIuL3wVrsM4kmYIo+xVdHsbw4+mfIQQhy8Ktsj8yNAX0sCZnePVMElM+tl2JrlkQQc
         pxaGudevsXhv2zxpcWJu23TvpheMiMFawHZUYuA0nHfVQh6IMorT8PfIRS1hzwTXTiGs
         nIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080158; x=1740684958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq0auaV2gz0U2k7ZsV3xhtnt/Z87hJ6m6ZAx0KCC4ZY=;
        b=VNkdIzEhXOutqxCTumHcBtKtBPEO/8sM9R/LTW+i8ffv8Q5NxoeRN6uQOz3SAC3c7w
         yYUJVzPUIqvKN1ayIMUhalWH7CQGGgFMAj9dpPzcdfsQEUtd02++p+PmfhRGxBzGfsvl
         Cr8ivjnu8gLft9x1ofGzaZhbkRmnxyYiRSpQho/cCsOcG6LIZL2dNvRc/+e4tlumxLXF
         a2FAAtQgMhboX+py5pB58TsGcl2oTw7kJdtuG9ooFeWGZgEdVgxEy7qf9MT3dz0tTCp5
         UXuxulUEp8AeqA5lFbPIzJjtlp3RyKQins0xPkdZyu9YzgcePlk0dkQZT9mJkc9jADqj
         QUkA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlKoG2+qIapJYKC0ocYr72EqCscUSc7tfsN5hLycD1Yg7uQfoFjM+OgaLLd/XpBDBmAVsVlQbK/NQjjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRZh6PUkOG7ZPYznc2ByJ1ar/EyAZ5gtuEWvyXNd3LpEa5ihR
	006y1jLVXHGi92YSZfo39Zl/F3AO+ng7LrNOW26MwWTMiZlUed8RLurtvPnhxx/rB1U7va0aKBv
	f
X-Gm-Gg: ASbGncuXRHm/7nmoP/UB76awzJ3XS1DBB1Po/kRWkap7hxLnXhTIUKv2xDTpLvnuGuJ
	T/RsaEIS6SIzH9UjlpIhPMb7d4vDnu6IO/4WFhK5eYWe8haZfbEQSWDFL1PDBMBtz3ZqPBK/Xht
	fRGNzxxDBK9Bb1RFVoMdwNbyqV/xXNe8OE69SDzUmbdPfqOstHeH2PMiWlXHdJY83CMcjkK2p4x
	AdUJvO1Nnd+w3nhWw79cVLy+CM10P3sjw5ZGBliQNyTuZo+uvRo/jyey+DSq4vaLh5A+L7i1hJX
	/kp/NEyzwMst2Yjl6hODEbbHxBI5Jck0jTlDDNr+P4dD0SZmGJyE9J3cAdInSkCTezrB5wvIVw=
	=
X-Google-Smtp-Source: AGHT+IH6lIxZerlRr77ih8We+DvTCu5urzGeLg20c0jFu0pBr5a/Hqe/QBdSDGwo66aHfXOcSlUTMQ==
X-Received: by 2002:a05:620a:2444:b0:7c0:9f12:2b9b with SMTP id af79cd13be357-7c0cef53633mr82056685a.35.1740080157909;
        Thu, 20 Feb 2025 11:35:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a4430sm89493726d6.65.2025.02.20.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:35:57 -0800 (PST)
Date: Thu, 20 Feb 2025 14:35:55 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>

On Thu, Feb 20, 2025 at 08:26:21PM +0100, David Hildenbrand wrote:
> On 20.02.25 19:43, Gregory Price wrote:
> 
> There were ideas in how to optimize that (e.g., requiring  a new sysfs
> interface to expose variable-sized blocks), if anybody is interested, please
> reach out.
> 

Multiple block sizes would allow managing the misaligned issues I
discussed earlier as well (where a memory region is not aligned to the
arch-preferred block size).  At least in that scenario, the misaligned
regions could be brought online as minimal block size (256MB) while the
aligned portions could be brought online in larger (2GB) chunks.

Do you think this would this require a lot of churn to enable? Last I dug
through hotplug, it seemed to assume block sizes would be uniform. I was
hesitant to start ripping through it.

~Gregory

