Return-Path: <linux-kernel+bounces-222138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AAF90FD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73F1B212D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D341C92;
	Thu, 20 Jun 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QblhbUMx"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AF2744C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866910; cv=none; b=PFHaR0y7rXDktnyJfBDH90/vqFSJmVnVJtmKPUN2T2g5LemoYcTMM514XLqA70LLiZZA476OG116J9IyxcvikUeUjaQ+m1j1vQgN3ejP+eYiGSkL/WGpk5EhgdkqnaMwEvNbVIeQfT8c86LnDC3xSz9S4+MKp5Lgo9Ng0VYm2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866910; c=relaxed/simple;
	bh=QQtpn/smuLvkV56HzwtCw5pAv16yzPHyp8Pzu33MgLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQQxj4RY6lbwq1lcnNqFLSj8U3W4ddmLL0vmndpiInNhP6tprNqQE90kIGyTNFfvYbp3M2Rs16JNkD9RRWEV+2Lcnwnjdcw7ETnoZ+LimBuitTf42B0POIoyC5PPNPEXwfJvjacTzl3qT5GoxT4THi4qezEkCjlabrJoo8OTO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QblhbUMx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70109d34a16so515826b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718866908; x=1719471708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibiGIkIJozxVRVQ0W/R98N1EhJWcdntoJXMh9zcTPvk=;
        b=QblhbUMxOb1EKUTdUqmUDY3FV1Vsi8Ticw9Enu5ovjH1M8rvnezK5N5+MBTJTr8nWd
         +w62OmWUXQOT2PYt8Mhkyy0As2zvec74qCrlo2zc2VfAUlQP0ulUYmrh0O1rO523Kl2A
         62bs9NABEBqsDEUOvk3rEovXe/labGP3aGUwzXmo2pphkVzvnkdXxmVGyquT/S8KIKAg
         c3hWJf6Bms+TnX5J+fFCpKk6TJZrLnmJTSUDcBYXY7IhPdOoN6kuqo9nVufE0y0Lig+M
         ZBjs21zpbmmBsqHwcsA3ZrfWcJC/uSt/GEieq5YvIETydgGKAplNjtXM887pcxFY9XKc
         6GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718866908; x=1719471708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibiGIkIJozxVRVQ0W/R98N1EhJWcdntoJXMh9zcTPvk=;
        b=anXdoOftidUqj51ejOHdjKc7so/Sfu6XLPiJCnKVI4Neq+eqwZE+UP/5GDm0NwU9Ur
         DpvF3fSQeClVOSK8C9JubZyaLEhhbObBcwRJl57rLjdfRF9KP/k7/HjbGGZdzG23uT8W
         +M2c6UdVklYVMQL4/UyRGlPULX5MMSfBp0hqlgYqNBhGSvhNwZQ6Pv6koZfqaKi0h27o
         bpfMHxKZC+AE0tPXtdGsN65TosOahS0Q6Xfgsi24QdVvI7rdCcVkjygz1DIrJqlFPP8W
         4AgHZEBzre3qQXhYMA/RCBGQb4gSH65BdDIbLigAblod+nymyB1j/sR4J0/b+mLbNV7S
         gclg==
X-Forwarded-Encrypted: i=1; AJvYcCWjLzloD+rnDQqM3Lhs8hHmnf3cesWeRfu+buatEYE3gQ3yVE470bLUQk/XBNt6TZMzPB0Lfo2vayOEfZ/KfEDagw5h2S3QW3LfzBI0
X-Gm-Message-State: AOJu0YyJiSbffA385ffcsBtqYk0kwz1Sv514tTa2Mph+MiYkF+hmSli6
	M4TVlRgLAbB+uaB7rHowyGClJqClxR1LiZMd8BEdwHpY2HpudWZ9FiIgr2afa44=
X-Google-Smtp-Source: AGHT+IHDyzJcEghpRsfweA27T0zs7L2wOX7octNPLrUWsJgbfYtwABrlONIhyLuVS3lq1wnWvWgthA==
X-Received: by 2002:a05:6a20:ae86:b0:1b6:dd1e:da3c with SMTP id adf61e73a8af0-1bcbb152c98mr4585211637.0.1718866908610;
        Thu, 20 Jun 2024 00:01:48 -0700 (PDT)
Received: from L4CR4519N7.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c85f4229sm8446535ad.156.2024.06.20.00.01.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Jun 2024 00:01:48 -0700 (PDT)
From: "$(name)" <qirui.001@bytedance.com>
X-Google-Original-From: "$(name)" <$(mail address)>
To: tony.luck@intel.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	qirui.001@bytedance.com,
	tglx@linutronix.de,
	x86@kernel.org
Subject: RE: [PATCH] x86/mce: count the number of occurrences of each MCE severity
Date: Thu, 20 Jun 2024 15:01:40 +0800
Message-Id: <20240620070140.12854-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/19/24 上午1:35, Luck, Tony wrote:
> 
>> In the current implementation, we can only know whether each MCE
>> severity has occurred, and cannot know how many times it has occurred
>> accurately. This submission supports viewing how many times each MCE
>> severity has occurred.
> 
> Is know how many times each case was hit useful? The original commit
> for this code said it was just to check coverage for the mce-test suite.
> 
> 4611a6fa4b37 ("x86, mce: export MCE severities coverage via debugfs")
> 
> So you either covered a case in the severities table, or you didn't. Does it
> help to know that you covered a case multiple times?
> 

In the fault injection test in the laboratory, we inject errors multiple
times and need a counter to tell us how many times each case has
occurred and compare it with the expected number to determine the test
results

In the production environment, the counter can reflect the actual number
of times each MCE error type occurs, which can help us detect the MCE
error distribution of large-scale Data center infrastructure 

>> Due to the limitation of char type, the maximum supported statistics are
>> currently 255 times
>>

How about changing char to u64, which is enough for real-world
situations and won't waste a lot of memory? 

>> Signed-off-by: Rui Qi<qirui.001@bytedance.com>
>> ---
>>   arch/x86/kernel/cpu/mce/severity.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index dac4d64dfb2a..a81e34c6e3ee 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -405,7 +405,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
>>                        continue;
>>                if (msg)
>>                        *msg = s->msg;
>> -             s->covered = 1;
>> +             s->covered++;
> 
> Wraparound sets this back to zero. Should this be:
> 
> 	if (s->covered < 255)
> 		s->covered++;
> 
> [Is there a #define for max value in an unsigned char? I could find one. If there is,
> then use that instead of hard coded 255]
> 
>>
>>                return s->sev;
>>        }--
> 
> -Tony

