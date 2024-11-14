Return-Path: <linux-kernel+bounces-409016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA439C8664
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1010D2833FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA01F7080;
	Thu, 14 Nov 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="tv9LlVQg"
Received: from sonic309-19.consmr.mail.sg3.yahoo.com (sonic309-19.consmr.mail.sg3.yahoo.com [106.10.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AD20ED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577516; cv=none; b=jeRFmTsUYIyvEEWAPy4jJyt1b9la/f2iZgkscWJONCUB44Dy7gsQnSVOFTfwaQozmKZDRZn2eMlP0dPbeV2KSliKQYK2T4Cx8mnZEP9LkQEUObozPfJSMeqTejqD1RooqBFm9JFow0KPUSB+2RUZqwB/BxFMhGXl7sw6ncH2oCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577516; c=relaxed/simple;
	bh=ujuFWP5IudXgfr6kb5/OHHUrPYxNktMIuuva0b0QnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNcQePQRxY3U22oYO6gZGbDEEtfYkLvSlK/QVnUByESM8q3sKSLR8SBr2hTTxLV7FhouJysusErOK03u3buLqGnjNqEJ5LUkjeqv1OjwMp8FSE7WxPhXaqE6fBxfexgj6C2l10UT6UQ0kkWCYYAjGjfgQtja4L18e4c7q8I64kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=tv9LlVQg; arc=none smtp.client-ip=106.10.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1731577513; bh=gJpyH1C6EU8gW7Mszbb3z0hswoif4TAAEvnVJ+e8GeA=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=tv9LlVQggX5d76KhQ26j0a0tD6Hr7ur+GxQ4/EhY1KplOC2NU0IdwUcTlrFSkcmWlFh7TBwI2xhAMmkeKci4hRi2njUYLJAQlq338qaJsCzqphNkYMVdNY0L/+TpDLufAFXwxrcJ2fwBfJDJoVZ5sJPaGWMEEvy/XJRTS5rRAsQCfwSE5JTXQ2wiYzdyiqiBuduB/e6ax1BExdsy0khmLv+s9SjvAVz/A6mINdAHE/eKF73XnPa7PLuSmugl1jXnvCx0xhjg8dFdEZuT6iA1pT0XbISFzgHjgMCGo+wrFyrVPM4dgqEwBmPwv5hxMgUQs/f0t/A9iIJnQw1o5gkatg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731577513; bh=bw07Ar9xuK3Fey/HpRz/xzGCB6QmTEWpYHW2y41AZeB=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=U4CnGDjPRZM9vyqDH4dSJzc9ugwCuE9O9AgQlV3BmIEfkLY+tepskdNY97P52bzWfm+FQMkoH8WJrnnlXkjYDleYJ1iJb87oC8E5lZlo6I2SKkpf/YrodDbrOSu8T1bLxnc3DjxMPADMYOAmwRFGf2iX8o7vTgDHAAmvHv+hBxnHjQmDaQttZu50SpKP6UN/c9hUv367lRf0NY47oy4z9OdMVX86W33N/+vLqpo5ydqqGPxlVUu8XHOx3pZiU1DDr+MKEla0KsGI0rS/RK4Ub9w9nik5bY6HFLbDCEsoOj4MJw4p50J9eWhwAJKui+s4hTUZxMd2sSxG+xogyIBFWQ==
X-YMail-OSG: 3um2ik0VM1n7muLuBxDgs_7b.c839jmepRhQwuTLuzCwrqPBp3QiuvVlXIhVwC6
 cmwVbWkI26TjX5Zx_pY9pgKF.J.S8wfNE_N5nkem4l4liRdVCOZFoWTHiwkuKd4vawBcXwtfnk6m
 ZjzdHLv.JZesvb7XA36yTVPeMyNNtiA.7p3AlXZ7GUq0UOsXHMNDjncp2SeEmlocNqQW46VBbvN0
 VbrgVf4e2qUca7lAl4t2q0H3x9zjN9qqp.D_lBK_bugSuJH.ycLfZh5EirFBK2T.RVgc6lsO6Gdz
 _VAM6F3nd340cH2lyguMhxGgO853RQlsXfGi8x_oKL69Zl90snmtm7Fth.DMgZxE3Bm9NKZDyaQd
 4l.6CHjuKQ0tI922mMHxlMvSiUmhIXPcQPXQPu.uo8ClE9xaIoSL6.PMwkanPkcxvIDCwqeMRF8F
 f0DuV58XIJMdkc54JKdqVdJE8w0r5J96G9n4BQRq0MpaKhM6YuGT7Y9dq.mw_zUmNC.Ej19poZWr
 DDFZG.SvVj4UcTiynXj4XuZ2KYT.Dc6NvBh6lshZqQd26ejCV6ewFnZtVwqQpPWx0tOJdiNQCXUG
 kXvfj0kpHnsCD1owgzES6W44obbMiaSfC20e_Mj0rLfmQwdaWnn3CmcOkaBu3z7fQ9INWaRk1YWv
 Fu3iCb69mcbrO0vx2AC0Wy0uKS0dWtB18asbTSvX.h2fixMRPBdBKz_uB_U0VKX3kSImsRna8x27
 x9TmDsJaMI.2Hie5aWh5QJP.JuGoB0pg.xxs9FSyFB4SaC_hYMVS0AhPzMVP381p4yuOryntO23_
 Mb9K7996Ywq20RJjhj5mCn0.BDGbvpmDEUhJ7hRWRxGl7kcG.XDFIqesm0h7WjnISoaYi3FJ63YS
 yOv7_IhMjrMA4Ol5_yveTsjY.6ElNX4Zsaqx6HjmKEpWqxw_1zTVsecTuP7gXUN6oBqB06G1aRm_
 asflfyaPViWEdMWtctygYNfMSggHuKEu13zF_Nizxy2sD5uIRk0kDuwNMofYQ2qvVuuqQyTdVdIK
 MarfOIxAWWs1AwSku_GK5LwaBibAX5zbFlVTrq_Fp4VWJ.8K7CAkQp0wgLGF.jXg.OKfvbqEoHdU
 yQgE1wZYSLeywOFwWCxHjIC5G9VCb0VoPgiXAVBPtfSDP8B1VVMN63laVXIVUX1wZLBfNQzmZkkJ
 OSbuaM2zN6jfWhBw5SzRVqs3nEGiTPyzEdmviQU_0wKZdbA4X8DRklkSQFnoM9V0JgMiRvUhUikm
 ym_eb0u9tIaCiLfNaLeDm6NhQOpfeT5heLSH.cISvFZYO8OozIet6HYMEvAh932hIV0c.G4kiG7T
 shPBYIKklJjtMZgccbWhJA66uMrDq9C2BkAYhDm7Ax4KKr9JebTne4h7AasG80MvD.1R.MLINmBj
 P8t8lzAGlEculpHByDPEWXlBDZEL3DwcJmmpWItDfvH8z8qYh_8lWnVWvJiBt4.4zWNl6NkNrDZX
 YJV3dPFn3gbRlpu9q33ogrY4b7HFErGoMvNx.DQP5k0Mc5XaRK6Yi_K_glxxI9yo79bBF4qGGPnL
 uyPO7aqZ0TZu3WEGr95X46VJhSA3lyJl3d8fFZo3.UFr17YZzvsGNDZdXimdVJLAenq1BFtJ3zgn
 URWTwSbVfGUz5VIUC9nE0cJFqRP8VruP06w8oDYZrJyo9EJiexYs6.QZtmTRvSHUXKINR_U2CH_e
 66FhhshbgwdP5gBmT4F21WwlheC3JaCcbZnA2S981Wu_AFys3SohbJEw4dzR3nUBdEk4oXRIVefc
 CONxUblgHfN4EjZ08FkrGTrCgSJQAMvtI5cJPvJtn0lWRlSVO2r1jZS.aLvlq1xiL5sRm24xbUSB
 TgYIsdUKl_K8jREBKRRUQRPH.XV_FEq1zgRcoBOZZ3znN06VJf.YBcvVA.VpyGIaB.eHq6l4F6lo
 Wsq5BDjIAM7c0D1uq7zVJSNi3KSGnRa4B6Ws5se3wCWXnX_dk94pe.DAXVP83vJ53pVZUq2GaCfQ
 Vn98nAinSvN03bWq6.1DjFamRJihFGyG_oDuXYuzRJVRxHf.pAnS4j3arGoygBDjLN.I.75nleI.
 feFcSV8uwJ_UeSqMRHT3S18ZWODkrcROWR5u4okmoFiVEqcpjI.559kAJ4Lj9aSWPiPu54803_yO
 q0SJvwhVw6mmAAJ7CWN0MoxhUyd5nkJ25RPMWF5F3mYQ5wh_fHamHwu3Bg823.bqnVNO1yGpi9kd
 rk1CnXI8wM2cwZFYhe1MPEvE2h7cwOxU-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: b5178632-0830-41e3-b50d-21924672062e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Thu, 14 Nov 2024 09:45:13 +0000
Received: by hermes--production-sg3-5b7954b588-xx7q2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f67cf62a101493f495e2da74bb42cb27;
          Thu, 14 Nov 2024 09:14:46 +0000 (UTC)
Date: Thu, 14 Nov 2024 14:44:42 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use strscpy() instead of strcpy()
Message-ID: <bigyu3u3rawsy5c5oxpe7xpmq24jhuxdrnklplaqjs2san7jxh@k3k2ypxcdspk>
References: <20241111221037.92853-1-abdul.rahim.ref@myyahoo.com>
 <20241111221037.92853-1-abdul.rahim@myyahoo.com>
 <8fef8eab-cd82-4e05-ad9b-1bb8b5fe974b@wanadoo.fr>
 <o6dz6grwkknan6er5lig6i37ocfekn6i3fljltptn7aol45sfl@n5amdhwr7wmt>
 <e7cfb6b2-51a4-4c8e-9c43-20653bd1443f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7cfb6b2-51a4-4c8e-9c43-20653bd1443f@wanadoo.fr>
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Wed, Nov 13, 2024 at 10:28:36PM +0100, Christophe JAILLET wrote:
> Le 13/11/2024 � 21:15, Abdul Rahim a �crit�:
> > On Tue, Nov 12, 2024 at 07:21:54AM +0100, Christophe JAILLET wrote:
> > > Le 11/11/2024 � 23:10, Abdul Rahim a �crit�:
> > > > strcpy() is generally considered unsafe and use of strscpy() is
> > > > recommended [1]
> > > > 
> > > > this fixes checkpatch warning:
> > > >       WARNING: Prefer strscpy over strcpy
> > > > 
> > > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > > > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > > > ---
> > > >    fs/ceph/export.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> > > > index 44451749c544..0e5b3c7b3756 100644
> > > > --- a/fs/ceph/export.c
> > > > +++ b/fs/ceph/export.c
> > > > @@ -452,7 +452,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
> > > >    		goto out;
> > > >    	if (ceph_snap(inode) == CEPH_SNAPDIR) {
> > > >    		if (ceph_snap(dir) == CEPH_NOSNAP) {
> > > > -			strcpy(name, fsc->mount_options->snapdir_name);
> > > > +			strscpy(name, fsc->mount_options->snapdir_name);
> > > 
> > > This does not compile because when the size of 'name' is not known at
> > > compilation time, you need to use the 3-argument version of strscpy().
> > > 
> > > Please always compile test your patches before sending them. Even, when the
> > > change looks trivial.
> > > 
> > 
> > Sure.
> > 
> > > CJ
> > > 
> > > >    			err = 0;
> > > >    		}
> > > >    		goto out;
> > > 
> > 

> > Should it be: NAME_MAX+1 ?
> > 
> > See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/exportfs.h?h=v6.12-rc7#n203
> > 
> > 
> 
> Looks like a good idea, maybe with a comment related to get_name() in the
> export_operations structure, so that we remind where this limit comes from?
> 
> CJ
> 

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 0e5b3c7b3756..48265c879fcf 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -452,7 +452,12 @@ static int __get_snap_name(struct dentry *parent, char *name,
 		goto out;
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
 		if (ceph_snap(dir) == CEPH_NOSNAP) {
-			strcpy(name, fsc->mount_options->snapdir_name);
+			/*
+			 * get_name assumes that name is pointing to a
+			 * NAME_MAX+1 sized buffer
+			 */
+			strscpy(name, fsc->mount_options->snapdir_name, 
+					NAME_MAX+1);
 			err = 0;
 		}
 		goto out;


Looks good?

