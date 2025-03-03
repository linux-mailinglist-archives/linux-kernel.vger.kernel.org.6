Return-Path: <linux-kernel+bounces-545226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98682A4EA78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DC74223A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD227EC70;
	Tue,  4 Mar 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRd2gM6u"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9220B1EB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110024; cv=pass; b=mE/KllRA7apCiUu4jTfBVK/85V2mdqsmgsS3tlFmt/p90PHHVgU5EGONbmfzpe+s8ntzGiNPWUJcgwz+QBK+Y7kwRCG9SiTcK/sxmMF3ZaHrIjm34c60nqbCPtANNKbw5O4mfBpaiZJgzdSWvxvV51dHdkrm0OedRoYVYJlGQ40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110024; c=relaxed/simple;
	bh=XlhOfTaeIsEIomGos2i6OtNmala9ugw1jqgVUucZjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT3R+PN2ueYVCDQfCCKfM+YpnNFFQSTmGc03X5osFC/37oEwwzho9wAjLWJ4/7S5i49DKdD2nJwyK0XHG2HJj5lA0l+rrQiAa9fOgSlQul8WWmFzFJVqUpmdre8YTvw/bGoTrMOALuEVuDJPmkFi1DDr5hElqvjKHPz+JY6rjP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRd2gM6u; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id F0807408B659
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:40:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cRd2gM6u
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gg84f1qzG2PT
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:12:04 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 702B24273C; Tue,  4 Mar 2025 19:11:45 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRd2gM6u
X-Envelope-From: <linux-kernel+bounces-541252-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRd2gM6u
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id BAC9741C3C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:14:33 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 90C382DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:14:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C598188601A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3321F0E43;
	Mon,  3 Mar 2025 09:14:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B71DE3A4;
	Mon,  3 Mar 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993246; cv=none; b=hzRc9cEgUPYtAE/mTLYdouiUEcCb18f1YJ6IHQvihz0X33C+xT9sYcCAaY8AK0NPpy9pysCQ3JtaLKr5K/Velqy3BcPqAruTb6oTLXuYaSAoJwogdtxCOfSTkYMTLItCNCXmDwkAM0ymXSntxwOyn4TkV07ftp/VRlzAL6juvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993246; c=relaxed/simple;
	bh=XlhOfTaeIsEIomGos2i6OtNmala9ugw1jqgVUucZjyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxz1hnObltM8Nh1ABn99uG+2DlGSgVw948jpjrTkk1AJ7gbyKaLozr/bJ4+XvGt2HuZcZtPx4F4hKvBD0TJbh0yBsr0FrIrhNHaSetbW9dSudY79OvwZx1e1zetboOAjVGd300msZrcM1xQyUZOlyZAdDQkoeukiUqoZiUyOXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRd2gM6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F816C4CED6;
	Mon,  3 Mar 2025 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740993245;
	bh=XlhOfTaeIsEIomGos2i6OtNmala9ugw1jqgVUucZjyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRd2gM6uQrRo8mSn7V8oWij/RsiuFSc265hBrma4U6e9HRcsIlTK/I4+GwLZXmbzc
	 0+OA3dciKjkmcakCxx3tEYKSiweOHPOJvwiMBO+6a2SNSBuBQj5J93dVrW1E7+w7RH
	 Dr9OfgmD8KDZw9f+wO6eAG162kKn+gGaC02fq+fZbnjodpdrYgf64gG+Iuj5Py7mLa
	 Cv9/6PtEbgunwkNhED0iPjCqjYqGyPLPnn5eNp1VK/ZjIcd6LaSG1T/F0uKt9Y57JE
	 E7N1AbWUyAkOPpX3tV8bNrqpvMO3z8bQ8jfqZZrXJpFChzUiEar/l7/NCh6vatds9d
	 mmquX+I0pVgIw==
Date: Mon, 3 Mar 2025 10:14:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg:
 introduce touchscreen support
Message-ID: <20250303-radical-private-pug-6bcc8a@krzk-bin>
References: <20250301-pocof1-touchscreen-support-v3-0-af01c3b30b55@joelselvaraj.com>
 <20250301-pocof1-touchscreen-support-v3-4-af01c3b30b55@joelselvaraj.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250301-pocof1-touchscreen-support-v3-4-af01c3b30b55@joelselvaraj.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gg84f1qzG2PT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714716.43378@k7XCatF9HDh9LVoY+RhYtw
X-ITU-MailScanner-SpamCheck: not spam

On Sat, Mar 01, 2025 at 05:43:10PM -0600, Joel Selvaraj wrote:
> Enable the Focaltech FT8719 touchscreen controller used in the Poco F1
> (EBBG) panel variant.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



