Return-Path: <linux-kernel+bounces-177371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D058C3DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC8A1C210DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE5148315;
	Mon, 13 May 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpHjJ5+j"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DC2B9D1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590747; cv=none; b=GVyjiS8c18P4EvmJ94Ut2oLJF+mHO3KAtG98YApO4wo6c3U/RMKVNyBOB8cfdOgA7IYWf9F+amH9wI4a7xsr3WzFyF7A+vbdUiisYfVqV5Crh6u9V4ZIqfOzpVC1P42BGjmjRasNU+JZ2k7lRh4k7/WcJ1lC8im6dMb2aArRkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590747; c=relaxed/simple;
	bh=agPBsFfNnqoao+mSKP9HtbMAlzkTfkEYJ3henh90y7E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ILSH1lyyPAStyn8Dz8VUFTW6b0AVDZm8VBnusIL8UP43Mso7j760Y7/bEUOvy4ZtF7KkpDbz3GCfSn9GELmfWUeVzKcWe58/q1cL5CiWxk1K9oxzJUCI8R4igrw/Np3N3qk+0bxrETIcpzjVj2Q7UJ0O22+1+VR/vtQEJCryWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpHjJ5+j; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59cdd185b9so871847466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715590744; x=1716195544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BONZtFMhDCloXM0WBlDley3CFN32CciOiMdKuHxFfJM=;
        b=XpHjJ5+jyJqmcvNcezb8j2MntUWLS9y9tSrBjl7FGJM8D7AQgiiJANYAJWceI+T0jb
         9b7UxyYuKW3fmOKU/OVe0+FW8WqQUVyzJeDfrLUbxkjgKdh9DPODtOX6wjpb3LsllIDw
         ZZHzebvWH7KCIbTMAY1oZqr8hqWUzQmrKLxrzTUM6i1IdjS67yqjq3HNjTsXpbV9G4UW
         qqzrIKW7+oGI142xkKLqDf4kKW/Pe97OCUzW8Tr5PbZhdMEr/Wvn/rMV3kTip3PBFeoV
         m70O5gCP5pM8kXQfJkYuW1F8vibrq6zbwhuJ7DUZgHd3CCLh5vDN8geSuSfbpjbW57J5
         uuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590744; x=1716195544;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BONZtFMhDCloXM0WBlDley3CFN32CciOiMdKuHxFfJM=;
        b=sFX6p0ajerZTSIwxGxXZOubqtkcoXBXLEYcFQYJhWwtig9bMByOG2BBkE+7M62qmAM
         tbSadNYCva9FGI3biQr0XUrxV2jT+JISPTBy4MFY/6d6auwuNf24YNyzhr+oHK0TllF8
         ygTGo3E2tCkPbVrMuYz3zsRSlfsL4QFc69eW3zCrKGwk731/d06GVgNlIdtICvQ03DlD
         GA2NoPYRSnDtvMivHc2eU6EdXtpQuRpfz/AbAONCcxA1jnDG0yLhf2pSBC08bhIk6xbf
         +5HCPWQhZaMpvqiTBW0YHAfqCT7CUwtY2+M66MOZHxS4mut3f0rTZinEcn5lgZz7FmtO
         rC6g==
X-Forwarded-Encrypted: i=1; AJvYcCX5FnllH+DHF100blWYdJWVhiUoaO6h9Fd5h/uYmhncKoD2xJGWgPUNEItQGB1O9DvuTowwnks9xTS4+EwHpQa0t/JOgQ+17tMenlxo
X-Gm-Message-State: AOJu0YxajabVLFt4rSz/2HWM+yrfz/ow76alnSgG3WE13oQDvEpLqUuZ
	klXtujjFOhdA34zYZFEi8nyGKfNA0z/GLfQnzOkbU7mw5dpmIQ8I
X-Google-Smtp-Source: AGHT+IH1XPGeEvCa1Jj/xKONwcdbsf4R6tlnSM/deBFWW5SD0Gs5spOwdhlOp5STcOkXh7eIxaxVBA==
X-Received: by 2002:a17:906:548:b0:a59:a01e:825f with SMTP id a640c23a62f3a-a5a2d292a95mr683570866b.29.1715590743914;
        Mon, 13 May 2024 01:59:03 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a3c8724edsm399452266b.34.2024.05.13.01.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 01:59:03 -0700 (PDT)
Message-ID: <0ed958b4-cbc9-4136-9113-e7a43a3f91e6@gmail.com>
Date: Mon, 13 May 2024 10:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ming.lei@redhat.com
Cc: benjamin.meier70@gmail.com, hch@lst.de, kbusch@kernel.org,
 kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, tglx@linutronix.de
References: <ZkHR1L/cJesDEn60@fedora>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <ZkHR1L/cJesDEn60@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > > The application which we develop and maintain (in the company I work)
 > > has very high requirements regarding latency. We have some isolated 
cores
 >
 > Are these isolated cores controlled by kernel command line `isolcpus=`?

Yes, exactly.

 > > and we run our application on those.
 > >
 > > Our system is using kernel 5.4 which unfortunately does not support
 > > "isolcpus=managed_irq". Actually, we did not even know about that
 > > option, because we are focussed on kernel 5.4. It solves part
 > > of our problem, but being able to specify where exactly interrupts
 > > are running is still superior in our opinion.
 > >
 > > E.g. assume the number of house-keeping cores is small, because we
 > > want to have full control over the system. In our case we have threads
 > > of different priorities where some get an exclusive core. Some 
other threads
 > > share a core (or a group of cores) with other threads. Now we are still
 > > happy to assign some interrupts to some of the cores which we 
consider as
 > > "medium-priority". Due to the small number of non-isolated cores, 
it can
 >
 > So these "medium-priority" cores belong to isolated cpu list, you 
still expect
 > NVMe interrupts can be handled on these cpu cores, do I understand 
correctly?

We want to avoid that the NVMe interrupts are on the "high priority" 
cores. Having
noise on them is quite bad for us, so we wanted to move some interrupts 
to house
keeping cores and if needed (due to performance issues) keep some on those
"medium-priority" isolated cores. NVMe is not that highest priority for us,
but possibly running too much on the house-keeping cores could also be bad.

 > If yes, I think your case still can be covered with 
'isolcpus=managed_irq' which
 > needn't to be same with cpu cores specified from `isolcpus=`, such as
 > excluding medium-priority cores from 'isolcpus=managed_irq', and
 > meantime include them in plain `isolcpus=`.

Unfortunately, our kernel version (5.4) does not support "managed_irq" 
and due
to that we're happy with the patch. However, I see that for newer kernel 
versions
the already existing arguments could be sufficient to do everything.

 > > be tricky to assign all interrupts to those without a 
performance-penalty.
 > >
 > > Given these requirements, manually specifying interrupt/core 
assignments
 > > would offer greater flexibility and control over system performance.
 > > Moreover, the proposed code changes appear minimal and have no
 > > impact on existing functionalities.
 >
 > Looks your main concern is performance, but as Keith mentioned, the 
proposed
 > change may degrade nvme perf too:
 >
 > 
https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/

Yes, but for NVMe it's not that critical. The most important point for us is
to keep them away from our "high-priority" cores. We still wanted to 
have control
where we run those interrupts, but also because we just did not know the 
"managed_irq"
option.

Thanks,
Benjamin

