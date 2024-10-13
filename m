Return-Path: <linux-kernel+bounces-362923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BBC99BB3D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847EA1C21177
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C409148314;
	Sun, 13 Oct 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="SwxOSpZX"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF212C54B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728847531; cv=none; b=AQ8YHuNZjut95yvOGvnc0tojA0s0LXAocr/4KKnBrg0Wyw101F9+DEsSWpj8NpMwoQsf6ACywoCjTcCcfhTy/rHwf1rXW+OT6d0JdRY5jNaOiP2kl19HWWzgLzKz6FARi5hFSPtiBAf5THSjkPRrYARAXuDS0tpbp8iPGFyKgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728847531; c=relaxed/simple;
	bh=pXVFMnSbHvGZWIWCxCZxNXJPAsc5cwNlWqgPr6lSV0M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EB+VuHAAffD0XbL1s7VNlxPkdVhgjTZSoNTU4O0LAM1l3c3jODLgqms5rw2xW/spBZfFIE7G6Pi/06QIbBmGkAN0sR2JCD1ufxlzGObKFZEXhShHKczKs60Svci+192sKbj/uHc2uAkN+SiYIudm0Tq+ecXPwgMX13YnZLby80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=SwxOSpZX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460464090d5so33940311cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728847527; x=1729452327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zrIznS7Q8l18arQCJjGYNCqnOxcKuCFvr5eSQ24gEg=;
        b=SwxOSpZXD4rPWDyQrn39H9k8aaY7KyjhwGr/2t/EsVmEqmnaYix6LoOLiQOgkpiuRX
         azkPqtFZN/tUZOUx0fCeSS6RDpkUykMiA+3BYSG5ikdOXMUdXHUXr1wvn+DSKViDrEsM
         VSMfMQcDD0Wp2hgwWJGhy9T/fk258Jo3nN5+23V/Y8X5hD9OVOKby5M9n52GVTTSLN0D
         LkQ15RFwKf10NbfKz7YS1rNIRUVw5ytL7Lul7NG2hcTjKi0Fnj0qJnXJZHl4zHOB00m2
         e2qtET0xhdajk/IYcRM6clxDkKeP1MbmRbE3U9DLS2zrb61cW8iRBhsB1KdDWMCcQ9Zp
         8l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728847527; x=1729452327;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zrIznS7Q8l18arQCJjGYNCqnOxcKuCFvr5eSQ24gEg=;
        b=QVRiD6zH+C2HoXwL3RoXPD6R8WfgAB5ezfCGMB8URIkfOA3KXSl91pESfYlIOtOw/M
         Ct46P+G9EVXprlIwwalgqRKr9BYXEtO4fmcMwW5ZVw6FEaUtFE+6qP6E+Z7w/o9dmRpP
         CN20A74R+1z+ZqbJeH8Atdzhn7BJgiuuiTzMjHt0y6V9Utt+wIlUMAIPIp46yNxcPFR2
         Mm64KcWQP+0759LBuBeYjTIr++ykKpTm+d026SnIQAzfytmd98cNxDzuzqRN+iSyyCx0
         Vin91fAbRzPYl9i3poM8IUvA42sBmqlEBMr1CxauhH1oYQDKfcnm2bcBFO6vfZfGoGvW
         cjVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwtAcjQX/CRqk/+PDGj7xkk/AeMFDLzDvuC4+m7ZxIGIwKgT/m0rT9JxsjcnEU3GW9gPPzD+hePF1U74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hY/WrByeSMNjJcsGkzm6QnpjnvYzoy0LioMYDWWD29G7B3B8
	/EGFshcE/3L2kJnxq5Vu1CoPADPfVeO7jjew2v+VltxJaIChd95w4cxQn8psIps=
X-Google-Smtp-Source: AGHT+IEJNYlsyx8T+jvHzQldZj2f3S8SmxEhhWozD8TMDGZMQODrTJu3Q0sDXFRzrKhgTK03uXP+/Q==
X-Received: by 2002:a05:6214:2b93:b0:6cb:99db:bdbf with SMTP id 6a1803df08f44-6cbf0051da6mr133964626d6.43.1728847527282;
        Sun, 13 Oct 2024 12:25:27 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b695fsm37792116d6.37.2024.10.13.12.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 12:25:26 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>
References: <20241013051239.22564-1-jonathan@marek.ca>
 <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <b13dc40b-cb72-02f6-0379-358499696eb2@marek.ca>
Date: Sun, 13 Oct 2024 15:22:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/13/24 1:30 PM, Ard Biesheuvel wrote:
> On Sun, 13 Oct 2024 at 07:16, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> v2:
>>   - changed to check for NUL character instead of size==1
>>   - reworked cleanup patch to remove cmd_line_len
>>   - moved 3rd commit out of this series
>>
>> Jonathan Marek (2):
>>    efi/libstub: fix efi_parse_options() ignoring the default command line
>>    efi/libstub: remove unnecessary cmd_line_len from
>>      efi_convert_cmdline()
>>
> 
> Thanks. I'm inclined to fold these together and just merge them as a
> single patch. Any objections?
> 

No objections (its not important to me, but if you want to get the fix 
into stable I think the separate commits makes that easier?)

