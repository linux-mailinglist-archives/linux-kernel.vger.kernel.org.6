Return-Path: <linux-kernel+bounces-444933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC49F0ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E4188125D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF51E4908;
	Fri, 13 Dec 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riCNhT4D"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3411E411C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099044; cv=none; b=uAAH56jIEnqrzvGviAfkwI/DUZ2EEY1+X2J9h8h/26BErLjTmJgxJ+K720WyThxznPaegOg6gGGPzAbqWZcTEK2k8BHtZ68ovw+/XQNfyABcHEmSk7QRA+UZ4HwBB0n3L8sB25Q+8I3jE0ALolHaT46HKfcU6j/HEFPXi8CRuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099044; c=relaxed/simple;
	bh=4vwGsM1sgE7tWIHGNhitdsUrLk0q5q8fYx52T6mOxls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbh1JlWHhjVc7iTvZarZx4HgLE1oeRtrnZxTtV8LwpJv4Du7NGUw49gA166gXuX6VeR4DM84vPf9vhEnZ8rRiqyN8L0AnN+XinIrnZjflccSw+15N6/H+mR+WD+TyEmMen3SyGZaLNhjnNdtkt8N7/AAOwrCdKU7mPSs+neerPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=riCNhT4D; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30033e07ef3so19023471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734099041; x=1734703841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1YcfEQwkNy5HAFAwqUbEfo5vhqkWM+UZF8BzuJJgTs=;
        b=riCNhT4Da1sqGYTVGliyp/WBMs1z93OFkyhw1MK0g68K2poY+mQdRm+saNkl9lO3j2
         2JOH0KiCxahSGXKU+NUpXBrMrlHPZQZHJ/61IdtOPZLnNVYKYLDg7nO85sWwjLbYfSQy
         EraOPjGRyCRs7D2kG6/oM9RtPP+VYaDPDwd69sIslIvXpzxa6x1jXGhxULyqGF7QZfuO
         B7MGMv2JyJnOpFzOX7YZMz0MBr8y0GIsG3UyYmVj/6FBadqCeqZnkQ1yVYfJAW5zzCgH
         6OIMbili6svi7kxWBSP9wyStrFTyCNpBX9tcJs9DXyr33UEbFMfA9oQAL9OFfN13D1pT
         RPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099041; x=1734703841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1YcfEQwkNy5HAFAwqUbEfo5vhqkWM+UZF8BzuJJgTs=;
        b=hiI0Dbukt3tsyboL5Jlk9gCWAN3QF0a24u8mxmQFMRJ3yNdf0EIvIKHNK/RkDk7VBF
         Gh5uMjQU7TMM7FiDa+NFZJGHqJraUl18TTtgDzKWkxBYibbBGSw5GtJrxMowgzP+JbHr
         Av8QHb8TpIVwEMJvwoEbD3gkAKouyMrjX6cNpMdCXUCvt2Cxed8GeWxkbdmMuVs/WPlL
         Mz2gIQZdohV1xMkD8+6hakhvYIPf8RNtjXG/uMdA4esBQIXvL1pxJwsKwG5cYsfMLl8/
         9xa1b5Fi1xKkfrg9w3OrkwjKhmM5ArJo490tZMkdxOM7I1D6pJJ+8oj4mq6mNeQgZb/J
         R6qA==
X-Forwarded-Encrypted: i=1; AJvYcCWi5Y+w+j1ruOXYkQgfyHmBzJ2xz6ExMVY0NH+XwSdCOB4ABh6rxfx6gQVX4rD994wzTK6CtxGU8JOGqoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2ARVN95yGMS+2YTM47A6X23yKCk9r0VJhUQ76cZQqocvnIXf
	tk5sXf/rcTjR69AH8CHIc4+IZpvmFyGVPvBnogcE1E8/BBl8r0Xkj1ip5wHQZos=
X-Gm-Gg: ASbGncuq1OdtBYFWjd6ZI5GbbQ+JqhFGZ2PJ06VBVKmEhzIQmjNn2uDJA+7B+atMJZj
	wx/Iuaj6vlFSDCFSni0oWqEgy08fizvTTSPxaF+EubdSC7VQ36gL4N/Lov/qS5Vh9Is3TZorcUt
	LmY3p9/oo2yKdZgtt+PTdIhEUzxZLyig9Jp9/ORX3JYRx6vkQcre6PKMs0d8kFlazms/zlZq6o4
	E3uP4tTSWn7IK2EuWTAmvb74myvzx2jdZ3jOGp1vzKEcwzp72YUZII1piMwnIe+lHOHR0iMu+kg
	A/x0UVCcWJnkqnYYzkLXJg5J1x9jtvTNnxgH
X-Google-Smtp-Source: AGHT+IGZCtr+/DlfpCqZVtFM0csLz4vmbTjJUn1ssjFmXM5IHARWF9p4eN3bbwFCK8xSKh8a8fEsOg==
X-Received: by 2002:a2e:be24:0:b0:302:1cfa:244b with SMTP id 38308e7fff4ca-30251c30882mr13038291fa.9.1734099040763;
        Fri, 13 Dec 2024 06:10:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300431a561csm19780001fa.116.2024.12.13.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:10:40 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Maud Spierings <maud_spierings@hotmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: Allow QSEECOM on the asus vivobook
 s15
Message-ID: <ct446vgy46m5in5ctz72crvbp6lbcof3ecj7bsboesm6itjcou@kqczzvvdvck4>
References: <20241116-add_asus_qcom_scm-v1-1-5aa2b0fb52bd@hotmail.com>
 <AM7P189MB10099F929FCE7AE7B348399DE33D2@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <da39ded1-8904-49a9-b58f-4d31c768bb55@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da39ded1-8904-49a9-b58f-4d31c768bb55@oss.qualcomm.com>

On Fri, Dec 13, 2024 at 02:02:12PM +0100, Konrad Dybcio wrote:
> On 10.12.2024 8:13 PM, Maud Spierings wrote:
> > I fear this may have slipped through the cracks as it has not yet gotten a response.
> > 
> > or does it have to do with [1]?
> > 
> > [1]: https://lore.kernel.org/all/20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org/
> 
> I'm not sure, but I'd much prefer for that one to land instead of
> having this list grow

It's on my todo list, but fist I need to sort out RO efivars support via
QSEECOM. I hope to have time for that during or after the weekend.

-- 
With best wishes
Dmitry

